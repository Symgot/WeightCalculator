# Weight Calculator - Entwicklerdokumentation / Developer Documentation

## Übersicht / Overview

**Deutsch:**
Dieser Mod für Factorio 2.0 fügt drei Hauptfunktionen hinzu:
1. Gewichtsrechner-Kombinator zur Berechnung des Gesamtgewichts von Gegenständen
2. Erweiterte Raketensilo-Signale für Kapazität und Gewicht
3. Schiffsanfrage-Monitor zur Überwachung von Schiffsanfragen

**English:**
This Factorio 2.0 mod adds three main features:
1. Weight Calculator combinator to calculate total weight of items
2. Extended Rocket Silo signals for capacity and weight
3. Ship Request Monitor to monitor ship requests

---

## Installation

### Deutsch
1. Lade den Mod herunter oder klone das Repository
2. Kopiere den Ordner in dein Factorio Mods-Verzeichnis:
   - Windows: `%appdata%\Factorio\mods\`
   - Linux: `~/.factorio/mods/`
   - Mac: `~/Library/Application Support/factorio/mods/`
3. Benenne den Ordner um zu: `WeightCalculator_1.0.0`
4. Starte Factorio und aktiviere den Mod im Mod-Menü

### English
1. Download the mod or clone the repository
2. Copy the folder to your Factorio mods directory:
   - Windows: `%appdata%\Factorio\mods\`
   - Linux: `~/.factorio/mods/`
   - Mac: `~/Library/Application Support/factorio/mods/`
3. Rename the folder to: `WeightCalculator_1.0.0`
4. Start Factorio and enable the mod in the mod menu

---

## Features

### 1. Gewichtsrechner / Weight Calculator

**Deutsch:**
Der Gewichtsrechner ist ein neuer Kombinator, der das Gesamtgewicht aller Gegenstände berechnet, die über rote und grüne Kabel verbunden sind.

**Funktionsweise:**
- Lies alle Item-Signale von roten und grünen Netzwerken
- Berechnet das Gewicht jedes Gegenstands basierend auf den Factorio-Spieledaten
- Gibt das Gesamtgewicht als Signal W (in kg) aus

**Verwendung:**
1. Forsche die Technologie "Gewichtsberechnung"
2. Baue einen Gewichtsrechner
3. Verbinde ihn mit einem Schaltungsnetzwerk, das Item-Signale enthält
4. Lies das W-Signal für das Gesamtgewicht in kg

**English:**
The Weight Calculator is a new combinator that calculates the total weight of all items connected via red and green wires.

**How it works:**
- Reads all item signals from red and green networks
- Calculates the weight of each item based on Factorio game data
- Outputs the total weight as signal W (in kg)

**Usage:**
1. Research the "Weight Calculation" technology
2. Build a Weight Calculator
3. Connect it to a circuit network containing item signals
4. Read the W signal for total weight in kg

---

### 2. Raketensilo-Erweiterung / Rocket Silo Extension

**Deutsch:**
Fügt drei neue virtuelle Signale zu Raketensilos hinzu, wenn sie mit einem Schaltungsnetzwerk verbunden sind.

**Neue Signale:**
- **Raketenkapazität**: Die maximale Ladekapazität der Rakete (in kg)
- **Freies Raketengewicht**: Das verfügbare Gewicht in der Rakete (in kg)
- **Belegtes Raketengewicht**: Das aktuelle Gewicht der Ladung in der Rakete (in kg)

**Verwendung:**
1. Verbinde ein Raketensilo mit einem Schaltungsnetzwerk
2. Aktiviere die Schaltungsverbindung am Raketensilo
3. Lies die drei neuen Signale:
   - `signal-rocket-capacity`
   - `signal-rocket-free-weight`
   - `signal-rocket-used-weight`

**English:**
Adds three new virtual signals to rocket silos when connected to circuit networks.

**New Signals:**
- **Rocket Capacity**: The maximum cargo capacity of the rocket (in kg)
- **Rocket Free Weight**: The available weight in the rocket (in kg)
- **Rocket Used Weight**: The current weight of cargo in the rocket (in kg)

**Usage:**
1. Connect a rocket silo to a circuit network
2. Enable the circuit connection on the rocket silo
3. Read the three new signals:
   - `signal-rocket-capacity`
   - `signal-rocket-free-weight`
   - `signal-rocket-used-weight`

---

### 3. Schiffsanfrage-Monitor / Ship Request Monitor

**Deutsch:**
Ein 1x1 großes Gebäude, das Anfragen von einem bestimmten Raumschiff überwacht.

**Funktionen:**
- Wähle ein Schiff zur Überwachung über die GUI aus
- Gibt nur aus, wenn sich das Schiff im selben Orbit wie der Planet befindet
- Gibt alle logistischen Anfragen des Schiffs aus
- Unterstützt alle gemoddeten Planeten und Raumplattformen

**Verwendung:**
1. Forsche die Technologie "Gewichtsberechnung"
2. Baue einen Schiffsanfrage-Monitor
3. Öffne das Gebäude (klicke darauf)
4. Wähle ein Schiff aus der Liste
5. Verbinde den Monitor mit einem Schaltungsnetzwerk
6. Die Anfragen des Schiffs werden ausgegeben, wenn es sich im selben Orbit befindet

**English:**
A 1x1 building that monitors requests from a specific spaceship.

**Features:**
- Select a ship to monitor via GUI
- Only outputs when the ship is in the same orbit as the planet
- Outputs all logistic requests from the ship
- Supports all modded planets and space platforms

**Usage:**
1. Research the "Weight Calculation" technology
2. Build a Ship Request Monitor
3. Open the building (click on it)
4. Select a ship from the list
5. Connect the monitor to a circuit network
6. The ship's requests will be output when it's in the same orbit

---

## Technische Details / Technical Details

### Gewichtsberechnung / Weight Calculation

**Deutsch:**
Das Gewicht wird direkt aus den Factorio-Spieldaten ausgelesen:
```lua
local weight = prototypes.item[item_name].weight
```

Das Gewicht wird in Gramm gespeichert, aber als kg ausgegeben (Division durch 1000).

**English:**
The weight is read directly from Factorio game data:
```lua
local weight = prototypes.item[item_name].weight
```

Weight is stored in grams but output as kg (divided by 1000).

### Update-Frequenz / Update Frequency

**Deutsch:**
- Gewichtsrechner: Aktualisiert jede Sekunde (60 Ticks)
- Raketensilo-Signale: Aktualisiert jede Sekunde (60 Ticks)
- Schiffsanfrage-Monitor: Aktualisiert jede Sekunde (60 Ticks)

**English:**
- Weight Calculator: Updates every second (60 ticks)
- Rocket Silo Signals: Updates every second (60 ticks)
- Ship Request Monitor: Updates every second (60 ticks)

---

## Kompatibilität / Compatibility

**Deutsch:**
- Factorio Version: 2.0 oder höher
- Benötigt: Space Age DLC
- Kompatibel mit allen Mods, die die Standard-Factorio-API verwenden
- Unterstützt gemoddete Planeten und Gegenstände

**English:**
- Factorio Version: 2.0 or higher
- Requires: Space Age DLC
- Compatible with all mods using standard Factorio API
- Supports modded planets and items

---

## Rezepte / Recipes

### Gewichtsrechner / Weight Calculator
- 5x Elektronikschaltkreis / Electronic Circuit
- 5x Kupferkabel / Copper Cable

### Schiffsanfrage-Monitor / Ship Request Monitor
- 5x Elektronikschaltkreis / Electronic Circuit
- 5x Eisenplatte / Iron Plate
- 5x Kupferkabel / Copper Cable

---

## Bekannte Einschränkungen / Known Limitations

**Deutsch:**
1. Der Schiffsanfrage-Monitor sucht nach Cargo Pods und Spider Vehicles
2. Die Raketenkapazität ist auf 1000 kg festgelegt (Standard für Factorio 2.0)
3. Die Schiffauswahl bleibt nicht nach einem Neustart des Spiels erhalten (muss neu ausgewählt werden)

**English:**
1. Ship Request Monitor searches for Cargo Pods and Spider Vehicles
2. Rocket capacity is fixed at 1000 kg (standard for Factorio 2.0)
3. Ship selection does not persist after game reload (needs to be reselected)

---

## Support & Entwicklung / Support & Development

**Deutsch:**
- GitHub: https://github.com/Symgot/WeightCalculator
- Issues: Bitte erstelle ein Issue auf GitHub
- Beiträge sind willkommen!

**English:**
- GitHub: https://github.com/Symgot/WeightCalculator
- Issues: Please create an issue on GitHub
- Contributions are welcome!

---

## Lizenz / License

Siehe LICENSE-Datei im Repository.
See LICENSE file in the repository.
