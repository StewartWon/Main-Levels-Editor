#!/bin/bash
# Simple build test script for Main Levels Editor

echo "=== Main Levels Editor Build Test ==="
echo "Checking CMake..."
cmake --version

echo ""
echo "Checking project structure..."
ls -la

echo ""
echo "Checking mod.json..."
cat mod.json | grep -E "(geode|version|gd)"

echo ""
echo "=== Build test complete ==="
echo "Note: To actually build, you need:"
echo "1. Geode SDK installed and GEODE_SDK environment variable set"
echo "2. Platform-specific build tools (Visual Studio, Xcode, Android NDK)"
echo "3. Run: cmake -B build && cmake --build build"
