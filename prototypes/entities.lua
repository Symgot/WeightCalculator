-- Entity prototypes for Weight Calculator mod

-- Weight Calculator Combinator
local weight_calculator = table.deepcopy(data.raw["constant-combinator"]["constant-combinator"])
weight_calculator.name = "weight-calculator"
weight_calculator.minable.result = "weight-calculator"
weight_calculator.circuit_wire_max_distance = 9

-- Ship Request Monitor (1x1 building based on wooden chest)
local ship_monitor = table.deepcopy(data.raw["container"]["wooden-chest"])
ship_monitor.name = "ship-request-monitor"
ship_monitor.type = "constant-combinator"
ship_monitor.minable.result = "ship-request-monitor"
ship_monitor.item_slot_count = 0
ship_monitor.circuit_wire_max_distance = 9
ship_monitor.circuit_connector_sprites = data.raw["constant-combinator"]["constant-combinator"].circuit_connector_sprites
ship_monitor.circuit_wire_connection_points = data.raw["constant-combinator"]["constant-combinator"].circuit_wire_connection_points

data:extend({
  weight_calculator,
  ship_monitor
})
