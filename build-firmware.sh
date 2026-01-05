#!/bin/bash
# Build firmware locally and create zip file
# Usage: ./build-firmware.sh

set -e

echo "🔨 Building firmware locally with Docker..."
echo ""

# Create workspace
mkdir -p .workspace
cd .workspace

# Initialize ZMK workspace
echo "Initializing ZMK workspace..."
docker run --rm \
  -v $(pwd):/workspace:Z \
  -v $(pwd)/../config:/workspace/config:Z \
  -v $(pwd)/../boards:/workspace/boards:Z \
  -w /workspace \
  zmkfirmware/zmk-build-arm:stable \
  /bin/bash -c "west init -l config && west update"

# Build left half
echo ""
echo "Building left half..."
docker run --rm \
  -v $(pwd):/workspace:Z \
  -v $(pwd)/../config:/workspace/config:Z \
  -v $(pwd)/../boards:/workspace/boards:Z \
  -w /workspace \
  zmkfirmware/zmk-build-arm:stable \
  /bin/bash -c "west build -s zmk/app -b eyelash_corne_left -d build/left -- -DSHIELD=nice_view"

# Build right half
echo ""
echo "Building right half..."
docker run --rm \
  -v $(pwd):/workspace:Z \
  -v $(pwd)/../config:/workspace/config:Z \
  -v $(pwd)/../boards:/workspace/boards:Z \
  -w /workspace \
  zmkfirmware/zmk-build-arm:stable \
  /bin/bash -c "west build -s zmk/app -b eyelash_corne_right -d build/right -- -DSHIELD=nice_view"

cd ..

echo ""
echo "📦 Creating firmware zip..."

# Create temp directory for firmware
mkdir -p firmware_temp

# Copy .uf2 files
cp .workspace/build/left/zephyr/zmk.uf2 firmware_temp/eyelash_corne_left-nice_view.uf2
cp .workspace/build/right/zephyr/zmk.uf2 firmware_temp/eyelash_corne_right-nice_view.uf2

# Create zip
zip -j firmware.zip firmware_temp/*.uf2

# Cleanup
rm -rf firmware_temp .workspace

echo ""
echo "✅ Done! Firmware saved to: firmware.zip"
ls -lh firmware.zip
echo ""
echo "📂 Contains:"
unzip -l firmware.zip
