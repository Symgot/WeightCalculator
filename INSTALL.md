# Installation Guide / Installationsanleitung

## Für Spieler / For Players

### Option 1: Automatische Installation über Factorio Mod Portal (empfohlen / recommended)

**Deutsch:**
1. Starte Factorio
2. Gehe zu Mods → Durchsuchen
3. Suche nach "Weight Calculator"
4. Klicke auf "Installieren"
5. Starte Factorio neu

**English:**
1. Start Factorio
2. Go to Mods → Browse
3. Search for "Weight Calculator"
4. Click "Install"
5. Restart Factorio

---

### Option 2: Manuelle Installation / Manual Installation

**Deutsch:**
1. Lade die neueste Version von GitHub herunter:
   ```
   https://github.com/Symgot/WeightCalculator/releases
   ```

2. Finde dein Factorio Mods-Verzeichnis:
   - **Windows**: `%appdata%\Factorio\mods\`
   - **Linux**: `~/.factorio/mods/`
   - **Mac**: `~/Library/Application Support/factorio/mods/`

3. Erstelle eine ZIP-Datei aus dem Mod-Ordner:
   - Der Ordner muss `WeightCalculator_1.0.0` heißen
   - Die Struktur sollte sein: `WeightCalculator_1.0.0/info.json`, `WeightCalculator_1.0.0/control.lua`, etc.

4. Kopiere die ZIP-Datei in dein Mods-Verzeichnis

5. Starte Factorio und aktiviere den Mod im Mod-Menü

**English:**
1. Download the latest version from GitHub:
   ```
   https://github.com/Symgot/WeightCalculator/releases
   ```

2. Find your Factorio mods directory:
   - **Windows**: `%appdata%\Factorio\mods\`
   - **Linux**: `~/.factorio/mods/`
   - **Mac**: `~/Library/Application Support/factorio/mods/`

3. Create a ZIP file from the mod folder:
   - The folder must be named `WeightCalculator_1.0.0`
   - Structure should be: `WeightCalculator_1.0.0/info.json`, `WeightCalculator_1.0.0/control.lua`, etc.

4. Copy the ZIP file to your mods directory

5. Start Factorio and enable the mod in the mod menu

---

## Für Entwickler / For Developers

### Development Setup

**Deutsch:**
1. Klone das Repository:
   ```bash
   git clone https://github.com/Symgot/WeightCalculator.git
   ```

2. Erstelle einen symbolischen Link vom Repository zu deinem Factorio Mods-Verzeichnis:
   
   **Linux/Mac:**
   ```bash
   ln -s /pfad/zum/WeightCalculator ~/.factorio/mods/WeightCalculator_1.0.0
   ```
   
   **Windows (als Administrator):**
   ```cmd
   mklink /D "%appdata%\Factorio\mods\WeightCalculator_1.0.0" "C:\pfad\zum\WeightCalculator"
   ```

3. Starte Factorio mit dem `--mod-directory` Flag für schnellere Entwicklung:
   ```bash
   factorio --mod-directory /pfad/zum/mods
   ```

**English:**
1. Clone the repository:
   ```bash
   git clone https://github.com/Symgot/WeightCalculator.git
   ```

2. Create a symbolic link from the repository to your Factorio mods directory:
   
   **Linux/Mac:**
   ```bash
   ln -s /path/to/WeightCalculator ~/.factorio/mods/WeightCalculator_1.0.0
   ```
   
   **Windows (as Administrator):**
   ```cmd
   mklink /D "%appdata%\Factorio\mods\WeightCalculator_1.0.0" "C:\path\to\WeightCalculator"
   ```

3. Start Factorio with the `--mod-directory` flag for faster development:
   ```bash
   factorio --mod-directory /path/to/mods
   ```

---

### Verzeichnisstruktur / Directory Structure

```
WeightCalculator/
├── info.json              # Mod metadata
├── data.lua              # Data stage (prototypes)
├── control.lua           # Control stage (runtime logic)
├── settings.lua          # Mod settings
├── changelog.txt         # Version history
├── README.md             # Project overview
├── DOCUMENTATION.md      # Detailed documentation
├── LICENSE               # License information
├── .gitignore           # Git ignore rules
│
├── prototypes/
│   ├── entities.lua     # Entity definitions
│   ├── items.lua        # Item definitions
│   ├── recipes.lua      # Recipe definitions
│   ├── signals.lua      # Virtual signal definitions
│   └── technology.lua   # Technology definitions
│
└── locale/
    ├── de/
    │   └── locale.cfg   # German translations
    └── en/
        └── locale.cfg   # English translations
```

---

### Testing

**Deutsch:**

1. **Syntax-Überprüfung:**
   ```bash
   # Lua-Syntax prüfen
   for file in *.lua prototypes/*.lua; do
     luac -p "$file"
   done
   
   # JSON-Syntax prüfen
   python3 -m json.tool info.json > /dev/null
   ```

2. **In-Game-Tests:**
   - Starte ein neues Spiel mit dem Mod aktiviert
   - Öffne die Konsole mit `~` (Tilde)
   - Aktiviere Cheats: `/c game.player.cheat_mode = true`
   - Erforsche Technologie: `/c game.player.force.research_all_technologies()`
   - Teste jede Funktion einzeln

3. **Log-Dateien:**
   - Factorio Log: `%appdata%\Factorio\factorio-current.log` (Windows)
   - Factorio Log: `~/.factorio/factorio-current.log` (Linux/Mac)

**English:**

1. **Syntax Checking:**
   ```bash
   # Check Lua syntax
   for file in *.lua prototypes/*.lua; do
     luac -p "$file"
   done
   
   # Check JSON syntax
   python3 -m json.tool info.json > /dev/null
   ```

2. **In-Game Testing:**
   - Start a new game with the mod enabled
   - Open console with `~` (tilde)
   - Enable cheats: `/c game.player.cheat_mode = true`
   - Research technology: `/c game.player.force.research_all_technologies()`
   - Test each feature individually

3. **Log Files:**
   - Factorio Log: `%appdata%\Factorio\factorio-current.log` (Windows)
   - Factorio Log: `~/.factorio/factorio-current.log` (Linux/Mac)

---

### Building a Release

**Deutsch:**

1. Aktualisiere die Versionsnummer in `info.json`
2. Aktualisiere `changelog.txt`
3. Erstelle eine ZIP-Datei:
   ```bash
   # Im Repository-Verzeichnis
   cd ..
   zip -r WeightCalculator_1.0.0.zip WeightCalculator/ \
     -x "*.git*" "*.github*" "*__pycache__*" "*.DS_Store"
   ```

4. Teste die ZIP-Datei, indem du sie in dein Mods-Verzeichnis kopierst
5. Erstelle ein GitHub Release mit der ZIP-Datei

**English:**

1. Update version number in `info.json`
2. Update `changelog.txt`
3. Create a ZIP file:
   ```bash
   # In repository directory
   cd ..
   zip -r WeightCalculator_1.0.0.zip WeightCalculator/ \
     -x "*.git*" "*.github*" "*__pycache__*" "*.DS_Store"
   ```

4. Test the ZIP file by copying it to your mods directory
5. Create a GitHub release with the ZIP file

---

## Anforderungen / Requirements

- Factorio 2.0 oder höher / or higher
- Space Age DLC
- Keine anderen Mod-Abhängigkeiten / No other mod dependencies

---

## Fehlerbehebung / Troubleshooting

**Deutsch:**

**Problem: Mod wird nicht geladen**
- Überprüfe, dass der Ordnername `WeightCalculator_1.0.0` ist
- Stelle sicher, dass `info.json` im Hauptverzeichnis liegt
- Überprüfe das Factorio-Log auf Fehler

**Problem: Gewichtsrechner zeigt keine Signale**
- Stelle sicher, dass Items über Kabel verbunden sind
- Überprüfe, dass die Technologie erforscht wurde
- Aktiviere den Kombinator im Schaltungsnetzwerk

**Problem: Schiffsmonitor findet keine Schiffe**
- Stelle sicher, dass Cargo Pods oder Spider Vehicles existieren
- Überprüfe, dass Space Age aktiviert ist

**English:**

**Issue: Mod doesn't load**
- Check that folder name is `WeightCalculator_1.0.0`
- Ensure `info.json` is in the root directory
- Check Factorio log for errors

**Issue: Weight calculator shows no signals**
- Make sure items are connected via wires
- Check that technology is researched
- Enable the combinator in circuit network

**Issue: Ship monitor finds no ships**
- Ensure Cargo Pods or Spider Vehicles exist
- Check that Space Age is enabled

---

## Support

- GitHub Issues: https://github.com/Symgot/WeightCalculator/issues
- Factorio Mod Portal: (Nach Veröffentlichung / After publication)
