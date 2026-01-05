#!/bin/bash
# Download pre-built firmware from GitHub Actions
# Usage: ./download-firmware.sh

set -e

echo "📦 Downloading firmware from latest successful build..."
echo ""

# Get the latest successful workflow run
RUN_ID=$(gh run list --workflow=build.yml --status=success --limit=1 --json databaseId --jq '.[0].databaseId')

if [ -z "$RUN_ID" ]; then
  echo "❌ No successful builds found!"
  exit 1
fi

echo "Found build: https://github.com/AnveshJarabani/zmk-corne/actions/runs/$RUN_ID"
echo ""

# Download all artifacts
mkdir -p firmware
cd firmware

echo "⬇️  Downloading firmware files..."
gh run download $RUN_ID

echo ""
echo "✅ Firmware downloaded to: firmware/"
echo ""
echo "📁 Available firmware:"
ls -lh
echo ""
echo "🎯 Flash these files to your keyboard:"
echo "   Left half:  firmware/eyelash_corne_left-nice_view_adapter-zmk/*.uf2"
echo "   Right half: firmware/eyelash_corne_right-nice_view_adapter-zmk/*.uf2"
echo ""
echo "💡 Optional settings_reset: firmware/settings_reset-eyelash_corne_left-zmk/*.uf2"
