-- Final fixes to integrate recipes into existing technologies

-- Add ship-request-monitor recipe to circuit-network technology
if data.raw.technology["circuit-network"] then
  local circuit_tech = data.raw.technology["circuit-network"]
  
  -- Initialize effects table if it doesn't exist
  circuit_tech.effects = circuit_tech.effects or {}
  
  -- Add ship-request-monitor recipe unlock
  table.insert(circuit_tech.effects, {
    type = "unlock-recipe",
    recipe = "ship-request-monitor"
  })
end

-- Add weight-calculator recipe to circuit-network technology
if data.raw.technology["circuit-network"] then
  local circuit_tech = data.raw.technology["circuit-network"]
  
  -- Add weight-calculator recipe unlock
  table.insert(circuit_tech.effects, {
    type = "unlock-recipe",
    recipe = "weight-calculator"
  })
end