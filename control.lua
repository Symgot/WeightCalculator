-- Weight Calculator Mod Control Script

-- Initialize global data
script.on_init(function()
  global.weight_calculators = global.weight_calculators or {}
  global.ship_monitors = global.ship_monitors or {}
end)

script.on_load(function()
  global.weight_calculators = global.weight_calculators or {}
  global.ship_monitors = global.ship_monitors or {}
end)

-- Configuration changed handler
script.on_configuration_changed(function()
  global.weight_calculators = global.weight_calculators or {}
  global.ship_monitors = global.ship_monitors or {}
end)

-- Weight Calculator Logic
local function calculate_item_weight(item_name, count)
  local item_proto = prototypes.item[item_name]
  if not item_proto then return 0 end
  
  local weight = item_proto.weight or 0
  return weight * count
end

local function update_weight_calculator(entity)
  if not entity or not entity.valid then return end
  
  local control = entity.get_control_behavior()
  if not control then return end
  
  local red_network = entity.get_circuit_network(defines.wire_connector_id.circuit_red)
  local green_network = entity.get_circuit_network(defines.wire_connector_id.circuit_green)
  
  local signals = {}
  
  -- Collect signals from red network
  if red_network then
    local network_signals = red_network.signals
    if network_signals then
      for _, signal in pairs(network_signals) do
        if signal.signal and (signal.signal.type == "item" or signal.signal.type == "fluid") then
          local name = signal.signal.name
          signals[name] = (signals[name] or 0) + signal.count
        end
      end
    end
  end
  
  -- Collect signals from green network
  if green_network then
    local network_signals = green_network.signals
    if network_signals then
      for _, signal in pairs(network_signals) do
        if signal.signal and (signal.signal.type == "item" or signal.signal.type == "fluid") then
          local name = signal.signal.name
          signals[name] = (signals[name] or 0) + signal.count
        end
      end
    end
  end
  
  -- Calculate total weight
  local total_weight = 0
  for item_name, count in pairs(signals) do
    total_weight = total_weight + calculate_item_weight(item_name, count)
  end
  
  -- Output weight signal (in kg, rounded)
  local weight_kg = math.floor(total_weight / 1000)
  
  if control.enabled then
    control.parameters = {
      {
        signal = {type = "virtual", name = "signal-W"},
        count = weight_kg,
        index = 1
      }
    }
  end
end

-- Rocket Silo Extension Logic
local function update_rocket_silo_signals(entity)
  if not entity or not entity.valid then return end
  if entity.name ~= "rocket-silo" then return end
  
  local control = entity.get_control_behavior()
  if not control or not control.enabled then return end
  
  -- Get rocket parts inventory and cargo
  local rocket_parts_inv = entity.get_inventory(defines.inventory.rocket_silo_rocket)
  local rocket_cargo_inv = entity.get_inventory(defines.inventory.rocket_silo_result)
  
  if not rocket_cargo_inv then return end
  
  -- Calculate rocket cargo weight
  local total_weight = 0
  local rocket_capacity = 1000000 -- 1000kg in grams (default for Factorio 2.0)
  
  -- Sum weight of all items in rocket cargo
  local contents = rocket_cargo_inv.get_contents()
  for item_name, count in pairs(contents) do
    total_weight = total_weight + calculate_item_weight(item_name, count)
  end
  
  local free_weight = math.max(0, rocket_capacity - total_weight)
  
  -- Output signals (convert from grams to kg)
  local output_signals = {}
  
  table.insert(output_signals, {
    signal = {type = "virtual", name = "signal-rocket-capacity"},
    count = math.floor(rocket_capacity / 1000),
    index = 1
  })
  
  table.insert(output_signals, {
    signal = {type = "virtual", name = "signal-rocket-free-weight"},
    count = math.floor(free_weight / 1000),
    index = 2
  })
  
  table.insert(output_signals, {
    signal = {type = "virtual", name = "signal-rocket-used-weight"},
    count = math.floor(total_weight / 1000),
    index = 3
  })
  
  -- Merge with existing control signals
  local existing_params = control.parameters or {}
  for i, param in ipairs(output_signals) do
    existing_params[i] = param
  end
  
  control.parameters = existing_params
end

-- Ship Request Monitor Logic
local function get_surface_location(surface)
  -- For Space Age, surfaces have locations (planets, orbits, etc)
  if surface.platform then
    return surface.platform.name or surface.name
  end
  return surface.name
end

local function update_ship_monitor(entity)
  if not entity or not entity.valid then return end
  
  local control = entity.get_control_behavior()
  if not control then return end
  
  -- Get the selected ship from entity settings
  local monitor_data = global.ship_monitors[entity.unit_number]
  if not monitor_data then return end
  
  local selected_ship = monitor_data.selected_ship
  if not selected_ship or not selected_ship.valid then
    -- Clear output if no valid ship selected
    if control.enabled then
      control.parameters = nil
    end
    return
  end
  
  -- Check if ship is in same orbit/location as the monitor
  local entity_location = get_surface_location(entity.surface)
  local ship_location = get_surface_location(selected_ship.surface)
  
  if entity_location ~= ship_location then
    -- Ship not in same location, clear output
    if control.enabled then
      control.parameters = nil
    end
    return
  end
  
  -- Get ship logistic requests
  local output_signals = {}
  local index = 1
  
  -- Try to get logistic point from the ship
  if selected_ship.get_logistic_point then
    local logistic_point = selected_ship.get_logistic_point(defines.logistic_member_index.vehicle_requester)
    
    if logistic_point then
      local sections = logistic_point.sections
      if sections then
        for _, section in pairs(sections) do
          if section.filters then
            for _, filter in pairs(section.filters) do
              if filter.value then
                local signal_data = {
                  signal = {type = filter.value.type, name = filter.value.name},
                  count = filter.min or 0,
                  index = index
                }
                table.insert(output_signals, signal_data)
                index = index + 1
                
                if index > 1000 then break end -- Safety limit
              end
            end
          end
        end
      end
    end
  end
  
  if control.enabled then
    control.parameters = #output_signals > 0 and output_signals or nil
  end
end

-- Entity built handler
local function on_entity_created(event)
  local entity = event.entity or event.created_entity or event.destination
  if not entity or not entity.valid then return end
  
  if entity.name == "weight-calculator" then
    global.weight_calculators[entity.unit_number] = {entity = entity}
  elseif entity.name == "ship-request-monitor" then
    global.ship_monitors[entity.unit_number] = {
      entity = entity,
      selected_ship = nil
    }
  end
end

script.on_event(defines.events.on_built_entity, on_entity_created)
script.on_event(defines.events.on_robot_built_entity, on_entity_created)
script.on_event(defines.events.script_raised_built, on_entity_created)
script.on_event(defines.events.script_raised_revive, on_entity_created)

-- Entity removed handler
local function on_entity_removed(event)
  local entity = event.entity
  if not entity or not entity.valid then return end
  
  if entity.name == "weight-calculator" then
    global.weight_calculators[entity.unit_number] = nil
  elseif entity.name == "ship-request-monitor" then
    global.ship_monitors[entity.unit_number] = nil
  end
end

script.on_event(defines.events.on_entity_died, on_entity_removed)
script.on_event(defines.events.on_player_mined_entity, on_entity_removed)
script.on_event(defines.events.on_robot_mined_entity, on_entity_removed)
script.on_event(defines.events.script_raised_destroy, on_entity_removed)

-- Update on tick for active entities
script.on_nth_tick(60, function(event)
  -- Update weight calculators every second
  for unit_number, data in pairs(global.weight_calculators) do
    if data.entity and data.entity.valid then
      update_weight_calculator(data.entity)
    else
      global.weight_calculators[unit_number] = nil
    end
  end
  
  -- Update ship monitors every second
  for unit_number, data in pairs(global.ship_monitors) do
    if data.entity and data.entity.valid then
      update_ship_monitor(data.entity)
    else
      global.ship_monitors[unit_number] = nil
    end
  end
  
  -- Update rocket silos every second
  for _, surface in pairs(game.surfaces) do
    local rocket_silos = surface.find_entities_filtered{name = "rocket-silo"}
    for _, silo in pairs(rocket_silos) do
      if silo.valid then
        update_rocket_silo_signals(silo)
      end
    end
  end
end)

-- GUI for ship selection
script.on_event(defines.events.on_gui_opened, function(event)
  local player = game.players[event.player_index]
  if not player then return end
  
  if event.entity and event.entity.valid and event.entity.name == "ship-request-monitor" then
    local monitor = event.entity
    
    -- Store monitor reference for later use
    player.opened = nil
    
    -- Create GUI for ship selection
    if player.gui.screen["ship-monitor-gui"] then
      player.gui.screen["ship-monitor-gui"].destroy()
    end
    
    local frame = player.gui.screen.add{
      type = "frame",
      name = "ship-monitor-gui",
      caption = {"gui.ship-monitor-title"},
      direction = "vertical"
    }
    frame.auto_center = true
    
    -- Store monitor unit number in frame tags
    frame.tags = {monitor_unit = monitor.unit_number}
    
    -- Find all cargo pods/ships in the game
    local ships = {}
    for _, surface in pairs(game.surfaces) do
      -- Look for space platforms and cargo pods
      local found_pods = surface.find_entities_filtered{type = "cargo-pod"}
      for _, pod in pairs(found_pods) do
        table.insert(ships, {entity = pod, label = "Cargo Pod - " .. surface.name})
      end
      
      -- Also look for spider vehicles (which could be used as ships)
      local found_spiders = surface.find_entities_filtered{type = "spider-vehicle"}
      for _, spider in pairs(found_spiders) do
        table.insert(ships, {entity = spider, label = "Spider - " .. surface.name})
      end
    end
    
    if #ships == 0 then
      frame.add{type = "label", caption = {"gui.no-ships-found"}}
    else
      local scroll = frame.add{
        type = "scroll-pane",
        direction = "vertical",
        vertical_scroll_policy = "auto",
        horizontal_scroll_policy = "never"
      }
      scroll.style.maximal_height = 400
      
      local list_flow = scroll.add{type = "flow", name = "ship-list", direction = "vertical"}
      
      for i, ship_data in pairs(ships) do
        local button = list_flow.add{
          type = "button",
          name = "ship-select-" .. i,
          caption = ship_data.label
        }
        button.tags = {ship_index = i}
        
        -- Store ship reference globally for selection
        global.temp_ships = global.temp_ships or {}
        global.temp_ships[player.index] = global.temp_ships[player.index] or {}
        global.temp_ships[player.index][i] = ship_data.entity
      end
    end
    
    local button_flow = frame.add{type = "flow", direction = "horizontal"}
    button_flow.add{type = "button", name = "ship-monitor-cancel", caption = {"gui.cancel"}}
    
    player.opened = frame
  end
end)

-- GUI button click handler
script.on_event(defines.events.on_gui_click, function(event)
  local player = game.players[event.player_index]
  if not player then return end
  
  local element = event.element
  if not element or not element.valid then return end
  
  -- Handle ship selection
  if string.find(element.name, "ship-select-") then
    local ship_index = element.tags and element.tags.ship_index
    if ship_index then
      local parent = element.parent
      while parent and parent.name ~= "ship-monitor-gui" do
        parent = parent.parent
      end
      
      if parent and parent.tags and parent.tags.monitor_unit then
        local monitor_unit = parent.tags.monitor_unit
        local monitor_data = global.ship_monitors[monitor_unit]
        
        if monitor_data and global.temp_ships and global.temp_ships[player.index] then
          local selected_ship = global.temp_ships[player.index][ship_index]
          if selected_ship and selected_ship.valid then
            monitor_data.selected_ship = selected_ship
            player.print({"", "Selected ship for monitoring"})
          end
        end
      end
    end
    
    -- Close GUI
    if player.gui.screen["ship-monitor-gui"] then
      player.gui.screen["ship-monitor-gui"].destroy()
    end
    
  elseif element.name == "ship-monitor-cancel" then
    -- Close GUI
    if player.gui.screen["ship-monitor-gui"] then
      player.gui.screen["ship-monitor-gui"].destroy()
    end
  end
end)

-- Clean up temp ships data when GUI closes
script.on_event(defines.events.on_gui_closed, function(event)
  local player = game.players[event.player_index]
  if not player then return end
  
  if event.element and event.element.valid and event.element.name == "ship-monitor-gui" then
    if global.temp_ships and global.temp_ships[player.index] then
      global.temp_ships[player.index] = nil
    end
  end
end)
