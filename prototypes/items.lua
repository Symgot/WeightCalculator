-- Item prototypes for Weight Calculator mod

data:extend({
  -- Weight Calculator item
  {
    type = "item",
    name = "weight-calculator",
    icon = "__base__/graphics/icons/constant-combinator.png",
    icon_size = 64,
    subgroup = "circuit-network",
    order = "c[combinators]-w[weight-calculator]",
    place_result = "weight-calculator",
    stack_size = 50
  },
  -- Ship Request Monitor item
  {
    type = "item",
    name = "ship-request-monitor",
    icon = "__base__/graphics/icons/wooden-chest.png",
    icon_size = 64,
    subgroup = "circuit-network",
    order = "c[combinators]-s[ship-monitor]",
    place_result = "ship-request-monitor",
    stack_size = 50
  }
})
