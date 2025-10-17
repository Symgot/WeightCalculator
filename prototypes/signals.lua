-- Virtual signals for the mod

data:extend({
  -- Weight signal
  {
    type = "virtual-signal",
    name = "signal-W",
    icon = "__base__/graphics/icons/signal/signal_W.png",
    icon_size = 64,
    subgroup = "virtual-signal",
    order = "z[weight-calculator]-a"
  },
  -- Rocket capacity signal
  {
    type = "virtual-signal",
    name = "signal-rocket-capacity",
    icon = "__base__/graphics/icons/rocket-silo.png",
    icon_size = 64,
    subgroup = "virtual-signal",
    order = "z[weight-calculator]-b"
  },
  -- Rocket free weight signal
  {
    type = "virtual-signal",
    name = "signal-rocket-free-weight",
    icon = "__base__/graphics/icons/rocket-part.png",
    icon_size = 64,
    subgroup = "virtual-signal",
    order = "z[weight-calculator]-c"
  },
  -- Rocket used weight signal
  {
    type = "virtual-signal",
    name = "signal-rocket-used-weight",
    icon = "__base__/graphics/icons/rocket.png",
    icon_size = 64,
    subgroup = "virtual-signal",
    order = "z[weight-calculator]-d"
  }
})
