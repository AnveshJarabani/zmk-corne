# ZMK Corne Keyboard Firmware

## Project Overview

ZMK firmware configuration for Eyelash Corne split keyboard:
- **Board**: Eyelash Peripherals Corne (48 keys + encoders)
- **Displays**: Nice!View
- **Features**: Bluetooth, mouse emulation, 52 combos, 6 layers

## Quick Reference

### Key Files

| File | Purpose |
|------|---------|
| `config/eyelash_corne.keymap` | Main keymap (edit this) |
| `config/eyelash_corne.conf` | ZMK feature flags |
| `.github/workflows/build.yml` | CI build workflow |
| `build-firmware.sh` | Local Docker build |
| `download-firmware.sh` | Download from GitHub |

### Common Commands

```bash
# Build via GitHub Actions (recommended)
git add config/eyelash_corne.keymap
git commit -m "feat: description"
git push origin main
gh run watch
./download-firmware.sh

# Local build (fallback)
./build-firmware.sh
```

## Build Validation

**CRITICAL: Always validate builds before considering keymap changes complete.**

### Preferred: GitHub Actions

1. Push changes to main branch
2. Monitor: `gh run watch`
3. Download: `./download-firmware.sh`

### Fallback: Local Docker

```bash
./build-firmware.sh
```

## Keymap Structure

### Position Map (48 total)

```
Left Half                    Center (Mouse)           Right Half
Row 0: 0-5                   6                        7-12
Row 1: 13-18                 19-21                    22-27
Row 2: 28-33                 34-35                    36-41
Row 3: 42-44 (thumbs)                                 45-47
```

### Layers

| Layer | Name | Purpose |
|-------|------|---------|
| 0 | default_layer | QWERTY + mouse |
| 1 | arrowandmouse | Navigation |
| 2 | NumPad | F-keys + numpad |
| 3 | specialchars | Symbols |
| 4 | arrowselect | Selection + BT |
| 5 | quarantine | Safety escape |

## Keymap Editing Checklist

Before committing:
- [ ] Read keymap first (understand current state)
- [ ] Verify position count (48 per layer)
- [ ] Check behavior references exist
- [ ] Build validation passed
- [ ] Descriptive commit message

## Combos

52 combos defined in `config/eyelash_corne.keymap:114-450`:
- Modifier combos (Ctrl, Shift, Alt, Win)
- Text navigation (Ctrl+Arrow, etc.)
- Text selection (Ctrl+Shift+Arrow)
- Window management (Shift+Win+Arrow)
- Media controls (recent addition)

## Bluetooth Controls

| Action | Binding | Location |
|--------|---------|----------|
| Soft-off | `&soft_off` | Layer 4, top-left |
| Disconnect | `&bt BT_DISC 0` | Layer 4, second row |
| Clear pairings | `&bt BT_CLR` | Layer 4, top-right |
| Next profile | `&bt BT_NXT` | Layer 2 |
| Prev profile | `&bt BT_PRV` | Layer 2 |

## Flashing Firmware

1. Double-tap reset button on keyboard half
2. Drag `.uf2` file to `NICENANO` drive
3. Wait for automatic reboot
4. Repeat for other half

## Documentation

- **Rules**: `.claude/rules/` - Keymap editing and build validation protocols
- **Commands**: `.claude/commands/` - `/build`, `/flash`, `/add-combo`, `/show-layer`
- **Skills**: `.claude/skills/` - ZMK behaviors and combo patterns
- **Guides**: `.claude/guides/` - Layer reference

## External Resources

- [ZMK Documentation](https://zmk.dev/docs)
- [ZMK Behaviors](https://zmk.dev/docs/behaviors)
- [Keymap Drawer](https://github.com/caksoylar/keymap-drawer) - Visualization
