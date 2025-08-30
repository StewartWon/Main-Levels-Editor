@echo off
REM Simple build test script for Main Levels Editor (Windows)

echo === Main Levels Editor Build Test ===
echo Checking CMake...
cmake --version

echo.
echo Checking project structure...
dir

echo.
echo Checking mod.json...
findstr "geode\|version\|gd" mod.json

echo.
echo === Build test complete ===
echo Note: To actually build, you need:
echo 1. Geode SDK installed and GEODE_SDK environment variable set
echo 2. Visual Studio 2022 or compatible build tools
echo 3. Run: cmake -B build && cmake --build build --config Release
