-- Entity prototypes for Weight Calculator mod

-- Weight Calculator Combinator
local weight_calculator = table.deepcopy(data.raw["constant-combinator"]["constant-combinator"])
weight_calculator.name = "weight-calculator"
weight_calculator.minable.result = "weight-calculator"
weight_calculator.circuit_wire_max_distance = 9

-- Ship Request Monitor (1x1 building based on constant-combinator)
local ship_monitor = table.deepcopy(data.raw["constant-combinator"]["constant-combinator"])
ship_monitor.name = "ship-request-monitor"
ship_monitor.minable.result = "ship-request-monitor"
ship_monitor.circuit_wire_max_distance = 9

-- Ensure all required combinator properties are present
ship_monitor.item_slot_count = ship_monitor.item_slot_count or 1000
ship_monitor.sprites = ship_monitor.sprites or data.raw["constant-combinator"]["constant-combinator"].sprites
ship_monitor.activity_led_sprites = ship_monitor.activity_led_sprites or data.raw["constant-combinator"]["constant-combinator"].activity_led_sprites
ship_monitor.activity_led_light = ship_monitor.activity_led_light or data.raw["constant-combinator"]["constant-combinator"].activity_led_light
ship_monitor.activity_led_light_offsets = ship_monitor.activity_led_light_offsets or data.raw["constant-combinator"]["constant-combinator"].activity_led_light_offsets
ship_monitor.circuit_connector_sprites = ship_monitor.circuit_connector_sprites or data.raw["constant-combinator"]["constant-combinator"].circuit_connector_sprites
ship_monitor.circuit_wire_connection_points = ship_monitor.circuit_wire_connection_points or data.raw["constant-combinator"]["constant-combinator"].circuit_wire_connection_points

-- Remove any container-specific properties that might cause conflicts
ship_monitor.inventory_size = nil
ship_monitor.picture = nil
ship_monitor.corpse = nil

-- Ensure placeable on all surfaces including modded planets
ship_monitor.surface_conditions = nil  -- Remove any surface restrictions
weight_calculator.surface_conditions = nil  -- Remove any surface restrictions

data:extend({
  weight_calculator,
  ship_monitor
})