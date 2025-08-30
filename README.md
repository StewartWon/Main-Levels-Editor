# Main Levels Editor

Allows you to control what levels should be in level select layer. 

**Updated for Geometry Dash 2.2074 and Geode SDK 4.8.0**

## What's New in v8.0.0-beta.11

- ✅ **Updated for Geometry Dash 2.2074** - Full compatibility with the latest GD version
- ✅ **Updated to Geode SDK 4.8.0** - Uses the latest Geode SDK with improved Unicode path handling
- 🔧 **Fixed path handling** - Replaced deprecated `std::filesystem::path::string()` calls with `string::pathToString()`
- 🏗️ **Added CI/CD** - Automated building for Windows, macOS, and Android

## Installation

1. Install [Geode](https://geode-sdk.org/) for Geometry Dash 2.2074
2. Download the latest `.geode` file from the [releases page](https://github.com/LatterRarity70/Main-Levels-Editor/releases)
3. Place it in your `geode/mods` folder
4. Launch Geometry Dash

## Building from Source

### Prerequisites
- CMake 3.21 or higher
- [Geode SDK](https://geode-sdk.org/) set up for your platform
- Visual Studio 2022 (Windows) / Xcode (macOS) / Android NDK (Android)

### Build Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/LatterRarity70/Main-Levels-Editor.git
   cd Main-Levels-Editor
   ```

2. Set up Geode SDK environment variable:
   ```bash
   # Windows
   set GEODE_SDK=path\to\geode\sdk

   # macOS/Linux
   export GEODE_SDK=/path/to/geode/sdk
   ```

3. Build:
   ```bash
   cmake -B build -DCMAKE_BUILD_TYPE=Release
   cmake --build build --config Release
   ```

4. The built `.geode` file will be in the `build` directory

### Temporary guide

#### <cr>at first i recommend you to read each setting info.</c>

Exporting and sharing levels: 
- "Export as .level file" button added to level pause layer. 
- By using this button you can create .level file of level you currently played and paused. 

The .level file is a ZIP archive of:
- _data.json
- Songs and SFXs files (mp3/ogg)

To replace level:
- export your level in .level file
- rename it to `{id}.level` (like 1.level)
- put it to mod config folder (or any other search paths of game)
- reload game

To add as new one:
- export level
- copy its id (f.e. 1337)
- add id to level listing setting (1337,1-22,-2,-1)
- reload game
