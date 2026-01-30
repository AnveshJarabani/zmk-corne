# Flash Firmware

Instructions for flashing firmware to the Eyelash Corne keyboard.

## Prerequisites

- `firmware/` directory contains `.uf2` files
- Keyboard halves accessible via USB

## Flashing Steps

1. **Put keyboard into bootloader mode**
   - Double-tap reset button on the half you're flashing
   - Should appear as `NICENANO` drive

2. **Flash left half**
   ```bash
   # Drag or copy the left .uf2 file
   cp firmware/eyelash_corne_left-nice_view.uf2 /path/to/NICENANO/
   ```

3. **Flash right half**
   ```bash
   # Repeat for right half
   cp firmware/eyelash_corne_right-nice_view.uf2 /path/to/NICENANO/
   ```

4. **Verify**
   - Keyboard should automatically reboot after flashing
   - Test key presses to confirm new layout

## Troubleshooting

- **Drive doesn't appear**: Try different USB cable, check reset button
- **Flash fails**: Ensure file copied completely before ejecting
- **Keys not working**: Ensure both halves are flashed with matching firmware versions
