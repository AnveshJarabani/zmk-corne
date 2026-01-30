# Build Validation Protocol

**Purpose**: Prevent broken firmware from being committed.

## Validation Required

**NEVER commit keymap changes without build validation.**

## Preferred Method: GitHub Actions

```bash
# 1. Commit and push
git add config/eyelash_corne.keymap
git commit -m "feat: description"
git push origin main

# 2. Monitor build
gh run watch

# 3. Download on success
./download-firmware.sh
```

## Fallback Method: Local Docker

```bash
# Only if GitHub Actions unavailable
./build-firmware.sh
```

## Build Failure Response

1. **Read error output** - Usually indicates:
   - Syntax errors in keymap
   - Undefined behavior references
   - Position count mismatch

2. **Fix and rebuild** - Don't commit broken code

3. **GitHub Actions is authoritative** - If local succeeds but GitHub fails, trust GitHub

## Post-Build Checklist

- [ ] Build completed successfully
- [ ] Firmware ZIP contains both halves
- [ ] Commit message describes changes
- [ ] No uncommitted changes remain
