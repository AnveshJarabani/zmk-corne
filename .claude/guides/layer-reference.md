# Layer Reference Guide

Complete reference for all layers in this keymap.

## Layer Overview

| Layer | Name | Purpose | Activation |
|-------|------|---------|------------|
| 0 | default_layer | QWERTY typing + mouse | Default |
| 1 | arrowandmouse | Navigation + mouse | Hold left thumb 1 |
| 2 | NumPad | Function keys + numpad | Layer-tap left thumb 2 |
| 3 | specialchars | Symbols | Layer-tap right thumb 2 |
| 4 | arrowselect | Selection + Bluetooth | Hold right thumb 3 |
| 5 | quarantine | Safety escape | from Layer 4 |

## Layer 0: default_layer (QWERTY)

Primary typing layer with integrated mouse control.

**Key Features:**
- Standard QWERTY layout
- Mouse movement in center columns
- Mouse click and scroll accessible
- Encoder: Volume control

## Layer 1: arrowandmouse (NUMBER)

Navigation and enhanced mouse control.

**Key Features:**
- Arrow keys
- Page Up/Down, Home/End
- Ctrl+Arrow for word navigation
- Mouse: Enhanced control with scroll
- Undo/Redo/Select-all shortcuts

## Layer 2: NumPad

Function keys and number pad layout.

**Key Features:**
- F1-F12 function keys
- Number pad (1-9, 0)
- `&soft_off` for power management
- Bluetooth: BT_NXT, BT_PRV
- System: Ctrl+Alt+Delete, Alt+F4

## Layer 3: specialchars (SYMBOL)

Symbol layer for programming.

**Key Features:**
- Shifted number row symbols: !@#$%^&*()
- Brackets: [], {}, <>
- Bluetooth output toggle
- Encoder: Volume control

## Layer 4: arrowselect (Fn)

Advanced navigation with text selection.

**Key Features:**
- Ctrl+Shift+Arrow for word selection
- Ctrl+Home/End/PgUp/PgDn
- Bluetooth controls:
  - `&soft_off` (top-left)
  - `&bt BT_DISC 0` (second row left)
  - `&bt BT_CLR` (top-right)
- Media: Play/Pause, Mute
- System: PrintScreen, ScrollLock

## Layer 5: quarantine

Safety escape layer.

**Purpose:** Escape if layers get stuck

**Key Features:**
- Mostly `&none` (disabled)
- `&to 0` to return to default layer
- Mouse movement retained for emergency navigation
