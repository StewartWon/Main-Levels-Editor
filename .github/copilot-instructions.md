<!-- Use this file to provide workspace-specific custom instructions to Copilot. For more details, visit https://code.visualstudio.com/docs/copilot/copilot-customization#_use-a-githubcopilotinstructionsmd-file -->

# Main Levels Editor - Geode Mod Development Guidelines

## Project Overview
This is a Geode mod for Geometry Dash that allows users to customize which levels appear in the level select screen. The mod supports importing/exporting custom .level files and provides a comprehensive level editor interface.

## Key Technologies
- **Geode SDK 4.8.0+** - Modern C++ modding framework for Geometry Dash
- **CMake 3.21+** - Build system
- **C++20** - Programming language standard
- **Geometry Dash 2.2074** - Target game version

## Code Style and Conventions

### File Handling
- Always use `string::pathToString()` instead of `std::filesystem::path::string()` for Unicode safety
- Use Geode's file utilities (`file::readJson`, `file::writeJson`, etc.) instead of raw filesystem calls
- Handle path operations safely with proper error checking

### Geode-Specific Guidelines
- Use `$modify` classes for hooking game functions
- Prefer Geode's UI components (`Popup`, `TextInput`, `ButtonSprite`) over raw Cocos2d
- Use `Ref<>` for automatic memory management of Cocos2d objects
- Follow Geode naming conventions with proper namespacing

### Memory Management
- Use RAII principles
- Prefer smart pointers and Geode's `Ref<>` system
- Always check for null pointers before dereferencing
- Clean up resources in destructors

### Error Handling
- Use Geode's `Result<>` type for operations that can fail
- Provide meaningful error messages to users via `Notification::create()`
- Log errors using `log::error()` for debugging

### UI Development
- Use Geode's layout system (`AxisLayout`, `RowLayout`) for responsive UIs
- Make UI elements accessible and intuitive
- Support both desktop and mobile interfaces
- Use consistent styling with Geometry Dash's theme

## Architecture Notes

### Core Components
- **Level File System**: Custom `.level` format for sharing levels with metadata and audio
- **Level List Management**: Dynamic level listing configuration
- **Editor Integration**: Hooks into GD's level editor for enhanced functionality
- **UI Overlays**: Custom popups and menus integrated into game flow

### Hook Points
- `LocalLevelManager`: For loading custom levels
- `GameLevelManager`: For level data management
- `LevelSelectLayer`: For custom level listings
- `EditorUI`: For level editor enhancements

## Important Considerations
- Always test on multiple platforms (Windows, macOS, Android)
- Ensure backwards compatibility with existing .level files
- Performance is critical - avoid blocking operations in game loops
- Unicode support is essential for international users
- Follow Geode's mod certification guidelines for distribution

## Common Pitfalls to Avoid
- Don't use raw `std::filesystem::path::string()` - use `string::pathToString()`
- Don't create UI elements on the main thread without proper scheduling
- Don't forget to handle edge cases in level ID parsing
- Don't modify game state without proper validation
- Don't block the UI thread with heavy file operations
