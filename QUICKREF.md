# Weight Calculator - Schnellreferenz / Quick Reference

## Schnellstart / Quick Start

### 1. Gewichtsrechner / Weight Calculator

```
Forschung: Gewichtsberechnung / Weight Calculation
Rezept: 5 Elektronikschaltkreis + 5 Kupferkabel
        5 Electronic Circuit + 5 Copper Cable

Verwendung / Usage:
├─ Bauen und platzieren / Build and place
├─ Mit Schaltungsnetzwerk verbinden / Connect to circuit network
├─ Item-Signale einspeisen / Feed item signals
└─ Signal W auslesen (Gesamtgewicht in kg) / Read signal W (total weight in kg)
```

### 2. Raketensilo-Signale / Rocket Silo Signals

```
Keine zusätzliche Forschung nötig / No additional research needed

Neue Signale / New Signals:
├─ signal-rocket-capacity     → Kapazität in kg / Capacity in kg
├─ signal-rocket-free-weight  → Freies Gewicht in kg / Free weight in kg
└─ signal-rocket-used-weight  → Belegtes Gewicht in kg / Used weight in kg

Verwendung / Usage:
└─ Raketensilo mit Schaltungsnetzwerk verbinden
   Connect rocket silo to circuit network
```

### 3. Schiffsanfrage-Monitor / Ship Request Monitor

```
Forschung: Gewichtsberechnung / Weight Calculation
Rezept: 5 Elektronikschaltkreis + 5 Eisenplatte + 5 Kupferkabel
        5 Electronic Circuit + 5 Iron Plate + 5 Copper Cable

Verwendung / Usage:
├─ Bauen und platzieren / Build and place
├─ Öffnen (anklicken) / Open (click)
├─ Schiff auswählen / Select ship
└─ Mit Schaltungsnetzwerk verbinden / Connect to circuit network
   → Gibt Anfragen aus, wenn Schiff im selben Orbit
   → Outputs requests when ship is in same orbit
```

## Signale / Signals

| Signal | Typ / Type | Bedeutung / Meaning |
|--------|-----------|---------------------|
| W | Virtual | Gesamtgewicht in kg / Total weight in kg |
| signal-rocket-capacity | Virtual | Raketenkapazität / Rocket capacity |
| signal-rocket-free-weight | Virtual | Freies Gewicht / Free weight |
| signal-rocket-used-weight | Virtual | Belegtes Gewicht / Used weight |

## Einstellungen / Settings

**Aktualisierungsrate / Update Rate**
- Standard / Default: 60 Ticks (1 Sekunde / 1 second)
- Bereich / Range: 10-600 Ticks
- Ort / Location: Einstellungen → Mod-Einstellungen → Laufzeit (Global)
                   Settings → Mod Settings → Runtime (Global)

## Tipps / Tips

**Deutsch:**
1. Verbinde mehrere Gewichtsrechner, um verschiedene Bereiche zu überwachen
2. Nutze Raketensilo-Signale für automatische Beladung bis zur Kapazität
3. Schiffsmonitore funktionieren nur im selben Orbit - verwende Radar zur Ortung
4. Niedrigere Aktualisierungsraten erhöhen den Rechenaufwand

**English:**
1. Connect multiple weight calculators to monitor different areas
2. Use rocket silo signals for automatic loading up to capacity
3. Ship monitors only work in same orbit - use radar for location
4. Lower update rates increase computational cost

## Kompatibilität / Compatibility

✓ Factorio 2.0+
✓ Space Age DLC
✓ Alle Mods mit Standard-API / All mods with standard API
✓ Gemoddete Planeten / Modded planets
✓ Gemoddete Items / Modded items

## Beispiele / Examples

### Beispiel 1: Automatische Raketenbeladung / Automatic Rocket Loading

```
Raketensilo → Schaltungsnetzwerk → Logistik-Anforderungscontainer
    ↓
signal-rocket-free-weight > 0 → Belade weiter / Continue loading
signal-rocket-free-weight = 0 → Stoppe Beladung / Stop loading
```

### Beispiel 2: Gewichtsbasierte Lagerung / Weight-based Storage

```
Lager → Gewichtsrechner → Schaltungsnetzwerk → Förderbänder
   ↓
Signal W < 1000 kg → Grün (weiter füllen) / Green (continue filling)
Signal W > 1000 kg → Rot (voll) / Red (full)
```

### Beispiel 3: Schiffsversorgung / Ship Supply

```
Schiffsmonitor → Schaltungsnetzwerk → Logistik-System
    ↓
Schiff in Orbit → Anfragen auslesen / Read requests
Schiff nicht in Orbit → Keine Ausgabe / No output
```

## Fehlerbehebung / Troubleshooting

| Problem | Lösung / Solution |
|---------|-------------------|
| Kein Signal W | Prüfe Kabelverbindungen / Check cable connections |
| Keine Raketensignale | Aktiviere Schaltung am Silo / Enable circuit at silo |
| Keine Schiffe gefunden | Baue Cargo Pods / Build cargo pods |
| Monitor gibt nichts aus | Schiff nicht im Orbit / Ship not in orbit |

## Support

📖 Dokumentation: `DOCUMENTATION.md`
🔧 Installation: `INSTALL.md`
🐛 Bugs: https://github.com/Symgot/WeightCalculator/issues
📝 Changelog: `changelog.txt`

---

**Version:** 1.0.0
**Autor / Author:** Symgot
**Lizenz / License:** Siehe LICENSE / See LICENSE
