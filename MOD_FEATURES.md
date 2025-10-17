# Weight Calculator - Feature Overview

## Implementierte Funktionen / Implemented Features

### ✅ 1. Gewichtsrechner-Kombinator / Weight Calculator Combinator

**Beschreibung / Description:**
Ein neuer Schaltungsnetzwerk-Kombinator, der das Gesamtgewicht aller Eingangssignale berechnet.
A new circuit network combinator that calculates the total weight of all input signals.

**Technische Details / Technical Details:**
- Liest Item-Signale von roten und grünen Kabeln / Reads item signals from red and green wires
- Verwendet die Factorio API: `prototypes.item[item_name].weight`
- Gibt Signal W in Kilogramm aus / Outputs signal W in kilograms
- Aktualisiert jede Sekunde (konfigurierbar) / Updates every second (configurable)

**Dateien / Files:**
- `prototypes/entities.lua` - Entity definition
- `prototypes/items.lua` - Item definition
- `prototypes/recipes.lua` - Recipe definition
- `control.lua` - Runtime logic (Zeilen 26-88 / Lines 26-88)

---

### ✅ 2. Raketensilo-Erweiterung / Rocket Silo Extension

**Beschreibung / Description:**
Erweitert Raketensilos um drei neue Schaltungssignale für Kapazitäts- und Gewichtsinformationen.
Extends rocket silos with three new circuit signals for capacity and weight information.

**Neue Signale / New Signals:**
1. **signal-rocket-capacity**: Maximale Kapazität der Rakete / Maximum rocket capacity
2. **signal-rocket-free-weight**: Verfügbares Gewicht / Available weight  
3. **signal-rocket-used-weight**: Aktuell belegtes Gewicht / Currently used weight

**Technische Details / Technical Details:**
- Liest Inventar: `entity.get_inventory(defines.inventory.rocket_silo_result)`
- Berechnet Gewicht aller Items im Raketenfrachtraum / Calculates weight of all items in rocket cargo
- Standard-Kapazität: 1000 kg (Factorio 2.0)
- Aktualisiert jede Sekunde / Updates every second

**Dateien / Files:**
- `prototypes/signals.lua` - Signal definitions
- `control.lua` - Runtime logic (Zeilen 90-147 / Lines 90-147)

---

### ✅ 3. Schiffsanfrage-Monitor / Ship Request Monitor

**Beschreibung / Description:**
Ein 1x1 großes Gebäude zum Überwachen von Anfragen eines bestimmten Raumschiffs.
A 1x1 building for monitoring requests from a specific spaceship.

**Funktionen / Features:**
- Schiffsauswahl über GUI / Ship selection via GUI
- Orbit-Prüfung (nur Ausgabe im selben Orbit) / Orbit checking (only outputs in same orbit)
- Unterstützt alle gemoddeten Planeten / Supports all modded planets
- Sucht Cargo Pods und Spider Vehicles / Searches for Cargo Pods and Spider Vehicles
- Gibt logistische Anfragen aus / Outputs logistic requests

**Technische Details / Technical Details:**
- Basiert auf Holzkisten-Textur / Based on wooden chest texture
- GUI zur Schiffauswahl / GUI for ship selection
- Orbit-Vergleich über Surface-Namen / Orbit comparison via surface names
- Logistic Point API: `entity.get_logistic_point()`

**Dateien / Files:**
- `prototypes/entities.lua` - Entity definition
- `prototypes/items.lua` - Item definition
- `prototypes/recipes.lua` - Recipe definition
- `control.lua` - Runtime logic (Zeilen 149-231, 308-416 / Lines 149-231, 308-416)

---

## Zusätzliche Features / Additional Features

### ✅ Konfigurierbare Aktualisierungsrate / Configurable Update Rate

**Einstellung / Setting:**
- Name: `weight-calculator-update-rate`
- Standard / Default: 60 Ticks (1 Sekunde / 1 second)
- Bereich / Range: 10-600 Ticks
- Typ / Type: Runtime Global Setting

**Dateien / Files:**
- `settings.lua` - Setting definition
- `locale/*/locale.cfg` - Translations

---

### ✅ Mehrsprachige Unterstützung / Multi-language Support

**Sprachen / Languages:**
- 🇩🇪 Deutsch (German) - Vollständig / Complete
- 🇬🇧 English - Vollständig / Complete

**Übersetzte Elemente / Translated Elements:**
- Entitätsnamen / Entity names
- Gegenstandsnamen / Item names
- Signalnamen / Signal names
- Technologien / Technologies
- GUI-Elemente / GUI elements
- Mod-Einstellungen / Mod settings

**Dateien / Files:**
- `locale/de/locale.cfg`
- `locale/en/locale.cfg`

---

### ✅ Technologiebaum / Technology Tree

**Technologie / Technology:**
- Name: Gewichtsberechnung / Weight Calculation
- Voraussetzung / Prerequisite: Schaltungsnetzwerk / Circuit Network
- Kosten / Cost: 100x (Automation + Logistic Science)
- Schaltet frei / Unlocks:
  - Gewichtsrechner / Weight Calculator
  - Schiffsanfrage-Monitor / Ship Request Monitor

**Dateien / Files:**
- `prototypes/technology.lua`

---

## Dokumentation / Documentation

### ✅ Vollständige Dokumentation / Complete Documentation

1. **README.md** - Projekt-Übersicht / Project overview
2. **DOCUMENTATION.md** - Detaillierte Funktionsbeschreibung / Detailed feature description
3. **INSTALL.md** - Installations- und Entwicklerhandbuch / Installation and developer guide
4. **QUICKREF.md** - Schnellreferenz / Quick reference
5. **changelog.txt** - Versionshistorie / Version history

---

## Qualitätssicherung / Quality Assurance

### ✅ Code-Qualität / Code Quality

- ✓ Lua-Syntax validiert / Lua syntax validated
- ✓ JSON-Struktur validiert / JSON structure validated
- ✓ Fehlerbehandlung implementiert / Error handling implemented
- ✓ Null-Checks für Entities / Null checks for entities
- ✓ Speicherverwaltung (Bereinigung ungültiger Entities) / Memory management (cleanup of invalid entities)

### ✅ Best Practices

- ✓ Verwendet Factorio 2.0 API / Uses Factorio 2.0 API
- ✓ Event-Filter zur Performance-Optimierung / Event filters for performance optimization
- ✓ Konfigurierbare Update-Frequenz / Configurable update frequency
- ✓ Lokalisierung für Mehrsprachigkeit / Localization for multi-language support
- ✓ Modulare Code-Struktur / Modular code structure

---

## Kompatibilität / Compatibility

### ✅ Anforderungen / Requirements

- Factorio: 2.0+
- DLC: Space Age
- Basis-Mod: ✓
- Andere Mods: Keine erforderlich / None required

### ✅ Unterstützt / Supports

- Alle gemoddeten Items / All modded items
- Alle gemoddeten Planeten / All modded planets
- Alle gemoddeten Oberflächen / All modded surfaces
- Standard Factorio API / Standard Factorio API

---

## Bekannte Einschränkungen / Known Limitations

1. **Schiffauswahl-Persistenz / Ship Selection Persistence:**
   - Schiffauswahl bleibt nicht nach Neustart erhalten
   - Ship selection does not persist after restart
   - Grund / Reason: Entities können nicht serialisiert werden / Entities cannot be serialized

2. **Raketensilo-Integration / Rocket Silo Integration:**
   - Verwendet Standard-Inventar-API / Uses standard inventory API
   - Kapazität ist fest auf 1000 kg / Capacity is fixed at 1000 kg
   - Grund / Reason: Factorio 2.0 Standard / Factorio 2.0 standard

3. **Performance:**
   - Update alle 60 Ticks (Standard) / Update every 60 ticks (default)
   - Kann bei vielen Entities CPU-intensiv sein / Can be CPU-intensive with many entities
   - Lösung / Solution: Konfigurierbare Update-Rate / Configurable update rate

---

## Testing-Checkliste / Testing Checklist

**Manuell im Spiel zu testen / To be tested manually in-game:**

- [ ] Gewichtsrechner platzieren und verbinden / Place and connect weight calculator
- [ ] Items über Schaltungsnetzwerk senden / Send items via circuit network
- [ ] Signal W auslesen / Read signal W
- [ ] Raketensilo mit Schaltungsnetzwerk verbinden / Connect rocket silo to circuit network
- [ ] Rakete beladen und Signale prüfen / Load rocket and check signals
- [ ] Schiffsmonitor bauen / Build ship monitor
- [ ] GUI öffnen und Schiff auswählen / Open GUI and select ship
- [ ] Orbit-Prüfung testen / Test orbit checking
- [ ] Mehrere Planeten testen / Test multiple planets
- [ ] Einstellungen ändern und testen / Change settings and test

---

## Zusammenfassung / Summary

Dieser Mod implementiert vollständig alle geforderten Funktionen:

✅ Gewichtsrechner-Kombinator mit automatischer Gewichtsberechnung
✅ Raketensilo-Erweiterung mit 3 neuen Signalen
✅ Schiffsanfrage-Monitor mit Schiffauswahl und Orbit-Prüfung
✅ Volle Unterstützung für Factorio 2.0 und Space Age
✅ Mehrsprachige Unterstützung (Deutsch/Englisch)
✅ Umfassende Dokumentation
✅ Konfigurierbare Einstellungen

This mod fully implements all requested features:

✅ Weight Calculator combinator with automatic weight calculation
✅ Rocket Silo extension with 3 new signals
✅ Ship Request Monitor with ship selection and orbit checking
✅ Full support for Factorio 2.0 and Space Age
✅ Multi-language support (German/English)
✅ Comprehensive documentation
✅ Configurable settings

**Status:** Bereit für In-Game-Tests / Ready for in-game testing
**Version:** 1.0.0
