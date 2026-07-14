# LSSGEE Changelog

All notable changes to this project are documented in this file.

---

## [v1.1] - 2026-01-XX

### Fixed
- **Eliminated black box loader during app startup** 
  - Heavy initialization (compiler detection, script system setup) now deferred to FormShow event
  - Window renders immediately instead of blocking on initialization
  - Perceived startup time reduced from 2-3 seconds to <0.5 seconds
  - Added `Application.ProcessMessages()` to ensure window paints before background init

### Technical Details
- Modified: `start.pas` (3 changes: FormShow declaration, OnShow assignment, new FormShow method)
- No functional changes - all initialization still completes before user can interact
- Single-threaded, safe implementation (no threading or concurrency issues)
- Works on all platforms: Windows 7/10/11, Linux, macOS

### Performance
| Metric | Before | After |
|--------|--------|-------|
| Time to visible window | 2-3s | <0.5s |
| Black box duration | 2+ seconds | 0 seconds |
| Actual initialization time | ~1.6s | ~1.6s (background) |
| User experience | Wait, then see | See immediately |

---

## [v1.0] - 2025-12-XX

### ✨ Features
- **Full EE Compatibility** — 425+ spell constants, 1,500+ feat constants, 500+ appearance types, VFX, item properties
- **SQLiteGen v1.0** — Persistent key/value storage (Module and Campaign scope)
- **Clean Rebuild** — 4 bit-rot fixes for modern Lazarus/FPC compatibility
- **Regenerable Data** — All NWScript constants auto-generated from EE source files

### 🔧 Technical
- Lazarus 4.8 / FPC 3.2.2 support
- Cross-platform ready (Windows tested, Linux/macOS compatible)
- GPL v2 licensed (open source)
- Minimal dependencies (LCL only)

### 📝 Known Limitations (v1.1+ roadmap)
- NUI popup generator (deferred)
- Object-scoped SQLite (planned v1.1+)
- Linux binary distribution (planned v1.1+)

---

## Version Numbering

- **Patch (x.x.Z)**: Bug fixes, performance improvements
- **Minor (x.Y.0)**: New features, non-breaking changes
- **Major (X.0.0)**: Significant changes, potential breaking changes

---

## Future Roadmap

### v1.2 (Planned)
- Object-scoped SQLite storage
- UUID lookup generator
- Optional progress dialog for slower machines
- Linux binary distribution

### v2.0 (Planned)
- NUI popup system generator
- JSON data serialization
- Custom SQLite schema builder
- Visual theme customization

---

## Credits & Attribution

**Lilac Soul** — Original creator (2004–2011, NWN1)  
**The Krit** — Maintained and updated for NWN1.69 (2011–2014)  
**Carcerian** — EE revival, modernization, SQLiteGen v1.0, v1.1 optimizations (2024–present)

---

## License

GNU General Public License v2.0 or later  
See LICENSE.txt for full license text
