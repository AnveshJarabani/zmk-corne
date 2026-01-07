# ZMK Corne Keyboard Firmware - Project Instructions

## Project Overview

This is a ZMK firmware configuration for an Eyelash Corne keyboard with:
- Split keyboard (left/right halves)
- Nice!View displays
- Bluetooth connectivity
- Mouse emulation and pointing device support
- Custom keymaps with combos

## Build Validation Process

### CRITICAL: Always validate builds before committing keymap changes

**Workflow:**
1. Make keymap changes in `config/eyelash_corne.keymap`
2. Validate locally OR push to trigger GitHub Actions
3. Monitor build status
4. Download firmware if successful

### Option 1: GitHub Actions Validation (Recommended)

**Advantages:**
- ✅ Official ZMK build environment (guaranteed compatibility)
- ✅ No local Docker setup needed
- ✅ Automatic firmware artifacts

**Steps:**
```bash
# 1. Commit your keymap changes
git add config/eyelash_corne.keymap
git commit -m "feat: your changes description"

# 2. Push to trigger build (requires manual terminal push to main)
# NOTE: Safety hooks block direct push to main - use terminal:
git push origin main

# 3. Monitor GitHub Actions
gh run list --limit 5
gh run watch  # Watch latest run

# 4. Download firmware when complete
gh run download <run-id>
# OR use the download script:
./download-firmware.sh
```

**GitHub Actions Details:**
- Workflow: `.github/workflows/build.yml`
- Triggers: Push to any branch (except keymap-drawer/**)
- Builds: Both left and right halves with nice_view shield
- Artifacts: `firmware.zip` containing `.uf2` files
- Build time: ~3-5 minutes

### Option 2: Local Docker Build (Advanced)

**Note:** Local builds can have environment issues. Use for quick validation only.

**Prerequisites:**
- Docker installed
- ~2GB disk space for ZMK workspace

**Build Script:**
```bash
./build-firmware.sh
```

**What it does:**
1. Creates `.workspace/` directory
2. Initializes ZMK workspace with `west init`
3. Updates dependencies with `west update`
4. Builds left half: `eyelash_corne_left` + `nice_view`
5. Builds right half: `eyelash_corne_right` + `nice_view`
6. Packages `.uf2` files into `firmware.zip`
7. Cleans up workspace

**Common Issues:**
- **"already initialized"**: Workspace exists. Move to TRASH:
  ```bash
  mkdir -p TRASH
  mv .workspace TRASH/.workspace-$(date +%Y%m%d-%H%M%S)
  echo ".workspace - moved to TRASH - rebuild needed" >> TRASH-FILES.md
  ```
- **Docker permission errors**: Run with sudo or add user to docker group
- **Build configuration errors**: Usually indicates keymap syntax issues

### Keymap Validation Checklist

Before committing keymap changes:

- [ ] **Syntax Check**: Read the keymap file to verify no typos
- [ ] **Behavior References**: Ensure all `&behavior` references exist:
  - `&soft_off` - Power management (requires ZMK)
  - `&bt BT_CLR` - Clear Bluetooth pairings
  - `&bt BT_DISC 0` - Disconnect Bluetooth profile 0
  - `&bt BT_NXT` / `&bt BT_PRV` - Cycle Bluetooth profiles
  - `&mkp`, `&mmv`, `&msc` - Mouse behaviors
  - `&rgb_ug` - RGB underglow (if enabled)
  - `&kp`, `&mo`, `&lt`, `&mt` - Standard ZMK behaviors

- [ ] **Layer Structure**: Verify layer bindings match matrix size (6 cols × 4 rows × 2 sides = 48 positions)
- [ ] **Sensor Bindings**: Each layer with encoders needs `sensor-bindings`
- [ ] **Build Validation**: Either GitHub Actions passed OR local build succeeded
- [ ] **Gitleaks Config**: Ensure `.gitleaks.toml` exists (prevents pre-commit failures)

### Files Modified Per Change

**Keymap changes only:**
- `config/eyelash_corne.keymap` - Main keymap file

**First-time setup additions:**
- `.gitleaks.toml` - Secret scanning config (prevents pre-commit hook failures)
- `TRASH-FILES.md` - Log of moved/deleted files (safety hook requirement)

**Build artifacts (git-ignored):**
- `.workspace/` - ZMK build environment (temporary)
- `firmware.zip` - Compiled firmware (temporary)
- `TRASH/` - Moved files (temporary)

### Pre-commit Hooks

This project has security hooks that scan for secrets:

**Checks performed:**
1. **Gitleaks**: Scans for leaked credentials (requires `.gitleaks.toml`)
2. **Email scan**: Detects hardcoded emails in code
3. **API token scan**: Detects API keys/tokens
4. **Private key scan**: Detects SSH/GPG keys
5. **Comment scan**: Checks for suspicious comments

**If pre-commit fails:**
- Check error message for detected secret
- Remove sensitive data
- Use `pass` or environment variables for secrets
- Update `.gitleaks.toml` allowlist if false positive

### Downloading Firmware

After successful GitHub Actions build:

**Method 1: GitHub CLI**
```bash
# List recent runs
gh run list --limit 5

# Download artifacts from specific run
gh run download <run-id>

# Download latest successful run
gh run download $(gh run list --status success --limit 1 --json databaseId --jq '.[0].databaseId')
```

**Method 2: Download Script**
```bash
./download-firmware.sh
```

**Method 3: GitHub Web UI**
1. Go to Actions tab: https://github.com/YOUR_USERNAME/zmk-corne/actions
2. Click latest successful "Build ZMK firmware" run
3. Scroll to Artifacts section
4. Download `firmware.zip`

### Flashing Firmware

1. Extract `firmware.zip`:
   - `eyelash_corne_left-nice_view.uf2`
   - `eyelash_corne_right-nice_view.uf2`

2. Put keyboard half into bootloader mode (usually double-tap reset button)

3. Drag `.uf2` file onto mounted drive (usually named `NICENANO`)

4. Wait for automatic reboot

5. Repeat for other half

### Project Structure

```
zmk-corne/
├── .github/workflows/
│   ├── build.yml          # Main firmware build
│   └── draw.yml           # Keymap visualization
├── boards/eyelash/eyelash_corne/
│   ├── eyelash_corne.dtsi         # Board definition
│   ├── eyelash_corne.keymap       # Default keymap (not used)
│   ├── eyelash_corne-layouts.dtsi # Layout definitions
│   ├── eyelash_corne_left.conf    # Left half config
│   ├── eyelash_corne_right.conf   # Right half config
│   └── board.yml                  # Board metadata
├── config/
│   └── eyelash_corne.keymap       # ⭐ YOUR KEYMAP (edit this!)
├── .gitleaks.toml                 # Secret scanning config
├── build-firmware.sh              # Local build script
├── download-firmware.sh           # Firmware download script
└── .gitignore                     # Ignored files
```

## Key Position Map

**CRITICAL: The Eyelash Corne has 48 total key positions (including mouse movement keys in the center).**

### Position Numbering (QWERTY Layout)

```
Left Half                    Center (Mouse)           Right Half
Row 0 (Top):
0:TAB  1:Q  2:W  3:E  4:R  5:T    6:MOVE_UP           7:Y  8:U  9:I  10:O  11:P  12:SEMI

Row 1 (Home):
13:ESC 14:A 15:S 16:D 17:F 18:G   19:MOVE_L 20:LCLK 21:MOVE_R   22:H 23:J 24:K 25:L 26:BSPC 27:SQT

Row 2 (Bottom):
28:SHIFT 29:Z 30:X 31:C 32:V 33:B   34:SCROLL 35:MOVE_D   36:N 37:M 38:COMMA 39:DOT 40:FSLH 41:REPEAT

Row 3 (Thumbs):
         42:mo1 43:layer2 44:SPACE                    45:ENTER 46:layer3 47:mo4
```

### Quick Position Reference

**Commonly used keys for combos:**
- **V key**: Position 32 (row 2, 5th key from left on left half)
- **B key**: Position 33 (row 2, 6th/rightmost key on left half)
- **I key**: Position 9 (row 0, top right)
- **J key**: Position 23 (row 1, home row right)
- **K key**: Position 24 (row 1, home row right)
- **L key**: Position 25 (row 1, home row right)

**Important Note:** When defining combos, always count the mouse movement keys in the center. They occupy positions 6, 19-21, 34-35.

## Keymap Layers

Current configuration has 5 layers (0-4):

0. **default_layer** (QWERTY) - Base typing layer
1. **arrowandmouse** (NUMBER) - Navigation and mouse control
2. **NumPad** - Function keys and number pad
3. **specialchars** (SYMBOL) - Symbols and special characters
4. **arrowselect** (Fn) - Text selection and Bluetooth controls

### Layer 4 (arrowselect) - Recent Changes

**Purpose:** Advanced navigation with text selection and system controls

**Key positions:**
- `[0,0]` (top-left): `&soft_off` - Enter low-power soft-off mode
- `[0,12]` (top-right): `&bt BT_CLR` - Clear all Bluetooth pairings
- `[1,0]` (second row, left): `&bt BT_DISC 0` - Disconnect Bluetooth profile 0

**Use cases:**
- Power management: Soft-off when not in use (saves battery)
- Bluetooth troubleshooting: Clear pairings or disconnect without clearing
- Text selection: Ctrl+Shift+Arrow combos for selecting text
- Navigation: Ctrl+Home/End/PgUp/PgDn

## Best Practices

### Making Keymap Changes

1. **Read the current keymap first** - Always use Read tool before editing
2. **Validate layer structure** - Count positions: 48 per layer for Corne
3. **Test behavioral references** - Check that all `&behaviors` are defined
4. **Use meaningful commit messages** - Describe what changed and why
5. **Validate builds** - Either GitHub Actions or local Docker build
6. **Document significant changes** - Update this file for major changes

### Commit Message Format

```
feat: update arrowselect layer with soft_off and BT controls

- Add soft_off to top-left position for low-power mode
- Add bt BT_DISC 0 to disconnect active Bluetooth profile
- Move bt BT_CLR to top-right position

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
```

### Safety Hooks

This project uses `.claude/` safety hooks:

**Pre-commit hooks:**
- Secret scanning (gitleaks + custom patterns)
- Email/API key/private key detection

**Git push hooks:**
- Protected branch blocking (main/master require manual push)
- Prevents accidental force pushes

**File deletion hooks:**
- Blocks `rm` commands
- Requires moving to `TRASH/` directory
- Requires `TRASH-FILES.md` documentation

## Troubleshooting

### Build Failures

**"unable to load gitleaks config"**
- **Cause:** Missing `.gitleaks.toml`
- **Fix:** Create minimal config (see above) or copy from another project

**"already initialized in /workspace"**
- **Cause:** `.workspace/` directory exists from previous build
- **Fix:** Move to TRASH and rebuild

**"pathspec did not match any files"**
- **Cause:** Wrong directory when running git commands
- **Fix:** `cd /root/zmk-corne` before git operations

**Configuration errors during build**
- **Cause:** Keymap syntax errors or undefined behaviors
- **Fix:** Check error output, validate keymap syntax

### GitHub Actions

**Build not triggering**
- Check push succeeded to main branch
- Verify `.github/workflows/build.yml` exists
- Check workflow isn't disabled in repo settings

**Build fails but local succeeds**
- GitHub Actions uses official ZMK environment (authoritative)
- Local environment may be outdated or misconfigured
- Trust GitHub Actions results over local builds

### Git Push Blocked

**"Git push to main/master is blocked"**
- **Cause:** Safety hook prevents accidental main pushes
- **Fix:** Use terminal for intentional main pushes:
  ```bash
  git push origin main
  ```
- **Alternative:** Create feature branch and merge via PR

## Related Documentation

- **ZMK Documentation**: https://zmk.dev/docs
- **Behaviors Reference**: https://zmk.dev/docs/behaviors
- **Board Configuration**: `boards/eyelash/eyelash_corne/`
- **GitHub Actions**: `.github/workflows/build.yml`

## Quick Reference Commands

```bash
# Build firmware locally
./build-firmware.sh

# Download latest firmware from GitHub
./download-firmware.sh

# Check build status
gh run list --limit 5
gh run watch

# Commit keymap changes
git add config/eyelash_corne.keymap
git commit -m "feat: description"

# Push (requires terminal for main branch)
git push origin main

# View git status
git status

# Move file to trash (instead of rm)
mkdir -p TRASH
mv file TRASH/file-$(date +%Y%m%d-%H%M%S)
echo "file - moved to TRASH - reason" >> TRASH-FILES.md
```
