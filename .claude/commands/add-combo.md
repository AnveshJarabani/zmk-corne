# Add Combo

Add a new key combo to the Eyelash Corne keymap.

## Required Information

Ask the user for:
1. **Trigger keys** - Which keys activate the combo (positions or key names)
2. **Output** - What the combo should produce
3. **Timeout** (optional) - Default is 30ms

## Combo Template

```c
combo_name {
    timeout-ms = <30>;
    key-positions = <POS1 POS2>;
    bindings = <&kp OUTPUT>;
    layers = <0>;  // Optional: restrict to specific layers
};
```

## Position Reference

```
Left Half                    Center (Mouse)           Right Half
Row 0: 0-5                   6                        7-12
Row 1: 13-18                 19-21                    22-27
Row 2: 28-33                 34-35                    36-41
Row 3 (Thumbs): 42-44                                 45-47
```

## Steps

1. Read current keymap: `config/eyelash_corne.keymap`
2. Find the combos section (around line 114-450)
3. Add new combo following existing patterns
4. Validate build with `/build` command

## Common Combo Patterns

- **Modifier combos**: Two adjacent keys produce Ctrl/Shift/Alt
- **Layer combos**: Thumb key combinations for layer access
- **Shortcut combos**: Common shortcuts like Undo, Redo, Copy, Paste
