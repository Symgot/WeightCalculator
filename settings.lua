-- Settings for Weight Calculator mod

data:extend({
  {
    type = "int-setting",
    name = "weight-calculator-update-rate",
    setting_type = "runtime-global",
    default_value = 60,
    minimum_value = 10,
    maximum_value = 600,
    order = "a"
  }
})
