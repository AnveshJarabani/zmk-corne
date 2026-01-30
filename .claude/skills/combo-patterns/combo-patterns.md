# Combo Patterns

Common combo patterns used in this keymap.

## Combo Syntax

```c
combo_name {
    timeout-ms = <30>;           // Time window (ms)
    key-positions = <POS1 POS2>; // Trigger positions
    bindings = <&kp KEY>;        // Output binding
    layers = <0 1 2>;            // Active layers (optional)
    require-prior-idle-ms = <100>; // Anti-accidental (optional)
};
```

## Modifier Combos

Adjacent keys produce modifiers:
```c
// Ctrl from adjacent keys
ctrl_jk {
    key-positions = <23 24>;  // J + K
    bindings = <&kp LCTRL>;
};
```

## Navigation Combos

Text navigation shortcuts:
```c
// Ctrl+Left (word left)
ctrl_left {
    key-positions = <22 23>;  // H + J
    bindings = <&kp LC(LEFT)>;
};
```

## Selection Combos

Text selection with modifiers:
```c
// Ctrl+Shift+Left (select word left)
ctrl_shift_left {
    key-positions = <14 15 16>;  // A + S + D
    bindings = <&kp LC(LS(LEFT))>;
};
```

## Best Practices

1. **Avoid conflicts** - Check existing combos before adding
2. **Use adjacent keys** - Easier to trigger intentionally
3. **Set timeouts appropriately** - 30-50ms typical
4. **Use `require-prior-idle-ms`** - Prevents accidental triggers while typing
5. **Document purpose** - Add comment above combo
