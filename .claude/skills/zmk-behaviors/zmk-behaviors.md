# ZMK Behaviors Reference

Quick reference for ZMK behavior syntax used in this keymap.

## Standard Behaviors

### Key Press
```c
&kp KEY          // Simple key press
&kp LCTRL        // Left Control
&kp LC(C)        // Ctrl+C (modified key)
```

### Modifiers
```c
LC(x)  // Left Ctrl + x
LS(x)  // Left Shift + x
LA(x)  // Left Alt + x
LG(x)  // Left GUI/Win + x
RC(x)  // Right Ctrl + x
// Combine: LC(LS(x)) = Ctrl+Shift+x
```

### Layers
```c
&mo LAYER        // Momentary layer (held)
&to LAYER        // Switch to layer (permanent)
&tog LAYER       // Toggle layer on/off
&lt LAYER KEY    // Tap for KEY, hold for LAYER
```

### Hold-Tap
```c
&mt MOD KEY      // Mod-tap: tap=KEY, hold=MOD
&lt LAYER KEY    // Layer-tap: tap=KEY, hold=LAYER
```

### Bluetooth
```c
&bt BT_CLR       // Clear all pairings
&bt BT_SEL 0     // Select profile 0
&bt BT_NXT       // Next profile
&bt BT_PRV       // Previous profile
&bt BT_DISC 0    // Disconnect profile 0
```

### Mouse
```c
&mmv MOVE_UP     // Mouse movement
&mkp LCLK        // Mouse click (left)
&mkp RCLK        // Mouse click (right)
&msc SCRL_UP     // Mouse scroll
```

### Power
```c
&soft_off        // Low-power soft-off mode
```

### Special
```c
&trans           // Transparent (use lower layer)
&none            // Nothing (block key)
```

## Custom Behaviors (This Keymap)

Check `config/eyelash_corne.keymap` lines 30-112 for:
- `&scroll_encoder` - Encoder scroll behavior
- `&volume_scroll` - Volume control encoder
- Tap-dance, hold-tap, and mod-morph definitions
