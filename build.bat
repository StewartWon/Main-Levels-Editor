@echo off
setlocal enabledelayedexpansion

echo ====================================
echo   Main Levels Editor - Build Script
echo ====================================
echo.

:: Check if cmake is available
where cmake >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: CMake is not installed or not in PATH
    echo Please install CMake and add it to your PATH
    pause
    exit /b 1
)

:: Check if we're in the right directory
if not exist "CMakeLists.txt" (
    echo ERROR: CMakeLists.txt not found
    echo Make sure you're running this from the project root directory
    pause
    exit /b 1
)

:: Build options
echo Build options:
echo.
echo [Build Configurations]
echo 1. Debug
echo 2. Release
echo 3. RelWithDebInfo (Recommended)
echo 4. MinSizeRel
echo.
echo [Advanced Options]
echo 5. Clean build folder and reconfigure
echo 6. Just clean build folder (exit after)
echo.
set /p config_choice="Enter your choice (1-6, default is 3): "

:: Handle advanced options first
if "%config_choice%"=="5" goto :clean_and_reconfigure
if "%config_choice%"=="6" goto :clean_only

:: Set configuration based on choice
if "%config_choice%"=="" set config_choice=3
if "%config_choice%"=="1" set BUILD_CONFIG=Debug
if "%config_choice%"=="2" set BUILD_CONFIG=Release
if "%config_choice%"=="3" set BUILD_CONFIG=RelWithDebInfo
if "%config_choice%"=="4" set BUILD_CONFIG=MinSizeRel

if not defined BUILD_CONFIG (
    echo Invalid choice. Using RelWithDebInfo.
    set BUILD_CONFIG=RelWithDebInfo
)
goto :continue_build

:clean_only
echo.
echo Cleaning build folder...
if exist "build" (
    rmdir /s /q build
    echo ✅ Build folder removed successfully!
) else (
    echo ℹ️  Build folder doesn't exist.
)
echo.
echo Press any key to exit...
pause >nul
exit /b 0

:clean_and_reconfigure
echo.
echo Cleaning build folder...
if exist "build" (
    rmdir /s /q build
    echo ✅ Build folder removed successfully!
) else (
    echo ℹ️  Build folder doesn't exist.
)
echo.
echo Select build configuration for clean build:
echo 1. Debug
echo 2. Release
echo 3. RelWithDebInfo (Recommended)
echo 4. MinSizeRel
echo.
set /p clean_config="Enter your choice (1-4, default is 3): "

if "%clean_config%"=="" set clean_config=3
if "%clean_config%"=="1" set BUILD_CONFIG=Debug
if "%clean_config%"=="2" set BUILD_CONFIG=Release
if "%clean_config%"=="3" set BUILD_CONFIG=RelWithDebInfo
if "%clean_config%"=="4" set BUILD_CONFIG=MinSizeRel

if not defined BUILD_CONFIG (
    echo Invalid choice. Using RelWithDebInfo.
    set BUILD_CONFIG=RelWithDebInfo
)

set FORCE_RECONFIGURE=1
goto :continue_build

:continue_build

echo.
echo Building with configuration: %BUILD_CONFIG%
echo.

:: Check if project needs configuration
if "%FORCE_RECONFIGURE%"=="1" (
    echo Forcing reconfiguration...
    goto :do_configure
)

if exist "build\CMakeCache.txt" (
    echo Project already configured, skipping configuration step...
) else (
    goto :do_configure
)
goto :do_build

:do_configure
:: Create build directory if it doesn't exist
if not exist "build" (
    echo Creating build directory...
    mkdir build
)

:: Add Geode CLI to PATH for this session
set "PATH=%PATH%;C:\geode-sdk\bin"

:: Configure the project
echo Configuring project...
cmake -B build -S . -A x64
if %errorlevel% neq 0 (
    echo.
    echo ❌ ERROR: CMake configuration failed!
    echo Check the output above for details.
    pause
    exit /b 1
)
echo ✅ Configuration successful!

:do_build

:: Build the project
echo.
echo Building project...
cmake --build build --config %BUILD_CONFIG% --parallel
if %errorlevel% neq 0 (
    echo.
    echo ERROR: Build failed!
    echo Check the output above for details.
    pause
    exit /b 1
)

:: Success message
echo.
echo ====================================
echo           BUILD SUCCESSFUL!
echo ====================================
echo.
echo Configuration: %BUILD_CONFIG%
echo Output file: build\user95401.main-levels-editor.geode
echo.

:: Check if the output file exists
if exist "build\user95401.main-levels-editor.geode" (
    echo The mod has been built successfully!
    echo.
    echo You can now:
    echo 1. Install the .geode file to your Geometry Dash mods folder
    echo 2. Copy it to: %%LOCALAPPDATA%%\GeometryDash\geode\mods\
    echo.
    
    :: Ask if user wants to open the output folder
    set /p open_folder="Open output folder? (y/n, default is y): "
    if "%open_folder%"=="" set open_folder=y
    if /i "%open_folder%"=="y" (
        start "" "build"
    )
) else (
    echo WARNING: Expected output file not found!
    echo Check the build output for issues.
)

echo.
echo Press any key to exit...
pause >nul
