# Build Firmware

Build and validate ZMK firmware for the Eyelash Corne keyboard.

## Steps

1. Check for uncommitted keymap changes
2. Commit if changes exist (ask user for commit message)
3. Push to trigger GitHub Actions build
4. Monitor build status with `gh run watch`
5. On success, download firmware with `./download-firmware.sh`

## Commands

```bash
# Check status
git status

# Commit changes
git add config/eyelash_corne.keymap
git commit -m "$USER_MESSAGE"

# Push (requires terminal for main branch due to safety hooks)
git push origin main

# Monitor
gh run watch

# Download
./download-firmware.sh
```

## Output

Report build status and firmware location when complete.
