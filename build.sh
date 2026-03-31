#!/bin/bash
# TinyBIOS MASM Build Script
# Uses JWasm via Wine

export WINEPREFIX=~/.wine32
export PATH="$PATH:/usr/bin"
JWASM="wine ./tools/JWasm.exe"
BASE="$(cd "$(dirname "$0")" && pwd)"

echo "Building TinyBIOS for ALI6117..."

# Build FILL files
cd $BASE
echo "Building FILL16..."
WINEPREFIX=~/.wine32 wine ./_tools/JWasm.exe -bin FILL16.ASM 2>&1
ls -la FILL16.BIN 2>/dev/null && mv FILL16.BIN ALI6117/

echo "Building FILL32..."
WINEPREFIX=~/.wine32 wine ./_tools/JWasm.exe -bin FILL32.ASM 2>&1
ls -la FILL32.BIN 2>/dev/null && mv FILL32.BIN ALI6117/

echo "Building FILL48..."
WINEPREFIX=~/.wine32 wine ./_tools/JWasm.exe -bin FILL48.ASM 2>&1
ls -la FILL48.BIN 2>/dev/null && mv FILL48.BIN ALI6117/

# Build BIOS
cd $BASE/ALI6117
echo "Building BIOS..."
WINEPREFIX=~/.wine32 wine ../_tools/JWasm.exe -bin BIOS.ASM 2>&1

if [ -f BIOS.BIN ]; then
    echo ""
    echo "Build successful: BIOS.BIN ($(wc -c < BIOS.BIN) bytes)"
else
    echo ""
    echo "Build failed - see errors above"
fi
