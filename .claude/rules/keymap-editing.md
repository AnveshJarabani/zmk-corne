# Keymap Editing Protocol

**Purpose**: Ensure safe, validated keymap modifications.

## Before Editing

1. **Always read the keymap first** - Never edit without understanding current state
2. **Verify position counts** - 48 positions per layer (including 6 mouse keys in center)
3. **Check behavior references** - Ensure all `&behaviors` exist in ZMK

## During Editing

### Position Reference

```
Left Half                    Center (Mouse)           Right Half
Row 0: 0-5                   6                        7-12
Row 1: 13-18                 19-21                    22-27
Row 2: 28-33                 34-35                    36-41
Row 3 (Thumbs): 42-44                                 45-47
```

### Common Behaviors

```
&kp KEY      - Key press
&mo LAYER    - Momentary layer
&lt LAYER KEY - Layer-tap
&mt MOD KEY  - Mod-tap
&bt BT_*     - Bluetooth controls
&soft_off    - Low-power mode
&mmv, &mkp, &msc - Mouse behaviors
```

## After Editing

1. **Build validation required** - Either GitHub Actions or local Docker
2. **GitHub Actions preferred** - Official ZMK environment
3. **Download firmware** - Use `./download-firmware.sh` after successful build

## Commit Format

```
feat|fix|refactor: brief description

- Detail 1
- Detail 2

Co-Authored-By: Claude <model>@<version> <noreply@anthropic.com>
```
