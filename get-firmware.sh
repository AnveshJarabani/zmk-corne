#!/bin/bash
# Build firmware locally and extract only .uf2 files
# Usage: ./get-firmware.sh

set -e

echo "🔨 Building firmware locally..."
echo ""

# Pull latest Docker image
docker pull zmkfirmware/zmk-build-arm:stable

# Build the firmware
docker run --rm \
  -v $(pwd)/config:/app/config:Z \
  -v $(pwd)/build:/app/build:Z \
  zmkfirmware/zmk-build-arm:stable \
  /bin/bash -c "west init -l config && west update && west build -s zmk/app -b eyelash_corne_left -- -DSHIELD=nice_view_adapter && west build -s zmk/app -b eyelash_corne_right -- -DSHIELD=nice_view_adapter"

echo ""
echo "📦 Extracting firmware files..."

# Create firmware directory
mkdir -p firmware

# Extract .uf2 files
find build -name "*.uf2" -exec cp {} firmware/ \;

echo ""
echo "🧹 Cleaning up build artifacts..."

# Remove build artifacts but keep firmware
rm -rf build/ zephyr/ zmk/ modules/ tools/ .west/ *.log

echo ""
echo "✅ Firmware ready in: firmware/"
ls -lh firmware/
echo ""
echo "🎯 Flash these files to your keyboard:"
echo "   Left half:  firmware/*left*.uf2"
echo "   Right half: firmware/*right*.uf2"
