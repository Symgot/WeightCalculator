# WeightCalculator

A Factorio 2.0 mod that adds weight calculation features, rocket silo extensions, and ship request monitoring.

## Features

### 1. Weight Calculator Combinator
A new circuit combinator that calculates the total weight of all items on connected circuit networks. The combinator reads all item signals from red and green wires and outputs the total weight as signal W (in kg).

### 2. Rocket Silo Extensions
Adds three new virtual signals for rocket silos when connected to circuit networks:
- **Rocket Capacity**: The maximum cargo capacity of the rocket
- **Rocket Free Weight**: The remaining weight capacity available
- **Rocket Used Weight**: The current weight of cargo loaded in the rocket

### 3. Ship Request Monitor
A 1x1 building that monitors requests from a specific space ship. Features:
- Select which ship to monitor via GUI
- Only outputs when the ship is in the same orbit as the planet
- Outputs all logistic requests from the selected ship
- Compatible with all modded planets

## Installation

1. Download the mod
2. Place in your Factorio mods folder
3. Enable in the mod menu

## Requirements

- Factorio 2.0 or higher
- Space Age DLC

## Usage

### Weight Calculator
1. Research "Weight Calculation" technology
2. Build a Weight Calculator
3. Connect to circuit network with item signals
4. Read the W signal for total weight

### Rocket Silo Signals
1. Connect rocket silo to circuit network
2. Read rocket-capacity, rocket-free-weight, and rocket-used-weight signals

### Ship Request Monitor
1. Build a Ship Request Monitor
2. Open the building GUI
3. Select a ship to monitor
4. Connect to circuit network to read ship requests

## License

See LICENSE file for details.
