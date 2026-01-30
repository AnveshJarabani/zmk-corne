# Show Layer

Display the current bindings for a specific layer.

## Usage

`/show-layer [layer_number]`

## Layers

- **0**: default_layer (QWERTY) - Base typing
- **1**: arrowandmouse (NUMBER) - Navigation and mouse
- **2**: NumPad - Function keys and numpad
- **3**: specialchars (SYMBOL) - Symbols
- **4**: arrowselect (Fn) - Text selection and Bluetooth
- **5**: quarantine - Safety escape layer

## Steps

1. Read `config/eyelash_corne.keymap`
2. Find the specified layer section
3. Format and display the bindings in a readable grid format

## Output Format

```
Layer X: layer_name
Row 0: [binding] [binding] [binding] [binding] [binding] [binding] | [center] | [binding] [binding] ...
Row 1: ...
Row 2: ...
Row 3 (Thumbs): ...
```
