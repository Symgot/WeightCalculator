-- Technology to unlock Weight Calculator features

data:extend({
  {
    type = "technology",
    name = "weight-calculator",
    icon = "__base__/graphics/technology/circuit-network.png",
    icon_size = 256,
    effects = {
      {
        type = "unlock-recipe",
        recipe = "weight-calculator"
      },
      {
        type = "unlock-recipe",
        recipe = "ship-request-monitor"
      }
    },
    prerequisites = {"circuit-network"},
    unit = {
      count = 100,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1}
      },
      time = 30
    },
    order = "a-d-d"
  }
})
