-- Recipe prototypes for Weight Calculator mod

data:extend({
  -- Weight Calculator recipe
  {
    type = "recipe",
    name = "weight-calculator",
    enabled = false,
    ingredients = {
      {type = "item", name = "electronic-circuit", amount = 5},
      {type = "item", name = "copper-cable", amount = 5}
    },
    results = {{type = "item", name = "weight-calculator", amount = 1}}
  },
  -- Ship Request Monitor recipe
  {
    type = "recipe",
    name = "ship-request-monitor",
    enabled = false,
    ingredients = {
      {type = "item", name = "electronic-circuit", amount = 5},
      {type = "item", name = "iron-plate", amount = 5},
      {type = "item", name = "copper-cable", amount = 5}
    },
    results = {{type = "item", name = "ship-request-monitor", amount = 1}}
  }
})
