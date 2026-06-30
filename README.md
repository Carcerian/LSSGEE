# Arcana: Lilac Soul's Script Generator EE

**Revival and modernization of Lilac Soul's legendary NWScript generator for Neverwinter Nights: Enhanced Edition**

---

## What is Arcana?

Arcana is a 2011-era NWScript code generator (Lilac Soul's tool, updated by The Krit) that has been revived, debugged, and enhanced for NWN:EE compatibility. It democratizes NWScript for novice builders and accelerates development for veterans.

Instead of hand-writing boilerplate NWScript:
- **Apply effects** to objects with visual/mechanical choices
- **Spawn creatures** and placeables with configured properties
- **Set persistent values** in module or campaign database (NEW in v1.0)
- **Manage conversations, inventory, journal entries, and more**

Arcana generates clean, well-documented NWScript code ready to drop into your scripts.

---

## What's New in v1.0?

### ✨ Features
- **Full EE Compatibility** — 425+ spell constants, 1,500+ feat constants, 500+ appearance types, VFX, item properties
- **SQLiteGen v1.0** — Persistent key/value storage (Module and Campaign scope)
- **Clean Rebuild** — 4 bit-rot fixes for modern Lazarus/FPC compatibility
- **Regenerable Data** — All NWScript constants auto-generated from EE source files

### 🔧 Technical
- Lazarus 4.8 / FPC 3.2.2 support
- Cross-platform ready (Windows tested, Linux/macOS possible)
- GPL v2 licensed (open source)
- Minimal dependencies (LCL only)

### 📋 What's NOT in v1.0 (Planned for v1.1+)
- NUI popup generator (deferred pending NUI API maturity)
- Object-scoped SQLite (v1.1 feature)
- Linux binary distribution (technical preparation done)

---

## Installation

### Requirements
- **Windows:** 7 / 10 / 11
- **Neverwinter Nights: Enhanced Edition** (for script testing)
- Lazarus 4.8 or later (if building from source)

### Quick Start
1. Download `scriptgenerator.exe` from the `linux/` folder (legacy path, contains Windows binary)
2. Run it — the generator will prompt for your NWN installation folder on first launch
3. Choose a generator from the menu, configure, click "Add to Script"
4. Copy generated code into your module's scripts

### From Source (Developers)
1. Extract the zip to a folder
2. Open `Scriptgen.lpi` in Lazarus
3. Press Shift+F9 to Rebuild
4. Output: `linux/scriptgenerator.exe`

---

## Using SQLiteGen v1.0

SQLiteGen creates persistent key/value storage for your module or campaign.

### Scope Options
- **Module-level:** Data persists within a module but resets when players enter a different area
- **Campaign-level:** Data persists across area transitions, ideal for player progression tracking

### Basic Usage

**To store a value:**
1. Launch Arcana
2. Click "SQLite Persistent Value"
3. Select scope (Module or Campaign)
4. Enter key name (e.g., `player_health`)
5. Enter value (e.g., `100`)
6. Click "Set Value"
7. Review generated code in the preview
8. Click "Add to Script" to insert into your module's script

**Generated code example:**
```nwscript
// Set persistent Module-level value
sqlquery sql_query;
sql_query = SqlPrepareQueryModule();

// Execute: INSERT OR REPLACE INTO variables (key, value)
SqlBindString(sql_query, 1, "player_health");
SqlBindString(sql_query, 2, "100");

if (SqlStep(sql_query) == SQL_FINISHED)
  SqlDebug("Variable stored: player_health");
else
  SqlDebug("ERROR storing variable");
```

**To retrieve a value:**
1. Click "SQLite Persistent Value"
2. Select the same scope
3. Enter the key name to retrieve
4. Click "Get Value"
5. Click "Add to Script"

**Generated retrieval code:**
```nwscript
// Get persistent Module-level value
sqlquery sql_query;
string sResult_player_health = "";
sql_query = SqlPrepareQueryModule();

// Execute: SELECT value FROM variables WHERE key=?
SqlBindString(sql_query, 1, "player_health");

if (SqlStep(sql_query) == SQL_ROW)
  sResult_player_health = SqlGetString(sql_query, 0);
else
  SqlDebug("Variable not found: player_health");

SqlDebug("Retrieved: " + sResult_player_health);
```

### Tips
- Use descriptive key names (e.g., `quest_stage_001`, not `x1`)
- Test retrieval in your scripts before relying on stored values
- Module-scoped values are faster; use Campaign scope only when necessary
- Combine with Carcerian's Tailor or other persistent storage systems as needed

---

## Other Generators (v1.0 Stable)

Arcana ships with 30+ generators covering:
- **Effects:** Apply magical effects, visual effects, spell resistance
- **Creatures & Placeables:** Spawn with full configuration
- **Inventory:** Give/take items, manage gold
- **Conversation:** Start conversations, manage journal
- **Combat:** Damage, healing, action queuing
- **Utility:** Delay commands, local variables, timestamps

Explore them all — each has detailed prompts and help text.

---

## Roadmap

### v1.1 (Planned, Early 2025)
- **Object-scoped SQLite** — Persistent data tied to specific creatures/placeables
- **UUID lookup generator** — Reference objects by persistent ID across saves
- **Effects fold-in** — VFX constants in effect generators
- Linux binary distribution

### v2.0 (Planned, Mid 2025)
- **NUI popup system** — Generate advanced UI popups for player interaction
- **JSON generator** — Data serialization and retrieval
- **Schema builder** — GUI for designing custom SQLite schemas
- Visual theme customization (color picker, font selection)

### Post-2.0
- macOS native binary
- CEP support (optional layer)
- Community generator plugins

---

## Credits & Attribution

**Lilac Soul** — Original creator (2004–2011, NWN1)
**The Krit** — Maintained and updated for NWN1.69 (2011–2014)
**Carcerian** — EE revival, modernization, SQLiteGen v1.0 (2024–present)

### Libraries & Tools
- **Lazarus IDE** — Free Pascal compiler and IDE
- **Free Pascal (FPC)** — Cross-platform Pascal compiler
- **LCL (Lazarus Component Library)** — Cross-platform GUI framework

---

## License

Arcana is released under the **GNU General Public License v2.0 or later**.

You are free to:
- Use Arcana for any purpose (commercial or personal)
- Modify the source code
- Redistribute it, with or without modifications
- Incorporate it into other projects

Under the condition that:
- You include the original license and attribution
- Any distributed derivative works also use GPL v2

For full license text, see `LICENSE.txt` in this distribution.

---

## Troubleshooting

**"NWN installation not found"**
- On first launch, Arcana asks for your NWN:EE folder
- Point it to your main NWN installation directory (where nwnmain.exe lives)
- Settings are saved; you can change them in Options → Locate Neverwinter Nights manually

**"Generated script syntax looks wrong"**
- Report with details to the project maintainer
- Paste the exact generated code and describe the issue
- Include your NWN:EE version

**"Can I use Arcana for X generator?"**
- Check the Roadmap above — features are planned by priority
- Requests welcome, but custom feature development is not currently available

---

## Support & Contact

**Issues, feature requests, or questions?**
- Check the FAQ in the generator's built-in help
- Review the Roadmap for planned features
- Report bugs with detailed reproduction steps

**Want to contribute or fork?**
- Arcana source is on GitHub (link in project metadata)
- GPL v2 allows forking and redistribution

---

## Version History

See `CHANGELOG.txt` for detailed version history, bug fixes, and credits.

---

**Arcana v1.0 — Built with precision, released with care. Long live Lilac Soul's legacy.**
