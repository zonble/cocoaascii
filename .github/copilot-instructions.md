# ASCII Converter for macOS
ASCII Converter is a simple macOS Cocoa application written in Objective-C that converts image files into ASCII artwork using drag-and-drop interface.

Always reference these instructions first and fallback to search or bash commands only when you encounter unexpected information that does not match the info here.

## Working Effectively
- **CRITICAL**: This is a macOS-only application. Building and running requires macOS with Xcode installed.
- **NEVER CANCEL**: Build commands may take 2-5 minutes depending on system. Set timeout to 10+ minutes.
- Build the application:
  - Open `ASCIIConverter.xcodeproj` in Xcode, OR
  - `xcodebuild` -- takes 2-5 minutes. NEVER CANCEL. Set timeout to 10+ minutes.
  - `xcodebuild -project ASCIIConverter.xcodeproj -scheme ASCIIConverter -configuration Release` -- for release builds
- Run the application:
  - From Xcode: Click "Build and Run" 
  - From command line: `open build/Release/ASCIIConverter.app` (after building)
- **VALIDATION SCENARIOS**: After making changes, always test:
  1. Launch the application and verify the main window opens
  2. Drag an image file (PNG, JPEG) to the main window
  3. Verify ASCII conversion appears in the text view
  4. Test width/height adjustment controls
  5. Test Copy, Save, and Save As functionality
  6. Test toolbar buttons (Insert Image, Copy, Save, Print)

## Requirements and Dependencies
- macOS 10.9 or higher
- Xcode (for building)
- No external dependencies - uses standard Cocoa frameworks only
- Application bundle size: ~1MB

## Build System
- **Build Tool**: `xcodebuild` (standard Xcode command-line tool)
- **Project File**: `ASCIIConverter.xcodeproj`
- **Build Configuration**: Debug (default) or Release
- **Target**: ASCIIConverter (single target)
- **Frameworks**: Cocoa.framework (automatically linked)
- **Build Output**: `ASCIIConverter.app` bundle in build directory

## Testing and Validation
- **No Unit Tests**: This project does not include automated tests
- **Manual Testing Required**: Always test functionality manually using validation scenarios above
- **CI Pipeline**: `.github/workflows/ci.yml` runs `xcodebuild` on macOS-latest
- **Build Time**: Typically 2-5 minutes on modern hardware. NEVER CANCEL builds.

## Code Organization
- **Main Application Logic**:
  - `MainController.{h,m}` - Primary window controller and application logic
  - `MainController+AppDelegate.{h,m}` - Application delegate methods
  - `MainController+Toolbar.{h,m}` - Toolbar configuration and actions
  - `MainController+Validation.{h,m}` - Input validation methods
- **Core Functionality**:
  - `NSImage+ASCII.{h,m}` - Image-to-ASCII conversion algorithm (brightness-based character mapping)
  - `ASCIIImageView.{h,m}` - Custom image view with drag-and-drop support
- **Entry Point**:
  - `main.m` - Application entry point (standard NSApplicationMain)
- **Resources**:
  - `English.lproj/MainMenu.xib` - Interface Builder file for main UI
  - `English.lproj/Localizable.strings` - English localization strings
  - `zh_TW.lproj/` - Traditional Chinese localization
  - `Images/` - Application icons and toolbar images

## Key Features and Implementation
- **Drag-and-Drop**: Implemented in `ASCIIImageView` with delegate pattern
- **ASCII Conversion**: Brightness-based character mapping in `NSImage+ASCII`
- **Character Set**: Uses `& 8 0 $ 2 1 | ; : ' ` and space based on pixel brightness
- **Size Controls**: Width/height text fields with validation (max 200x200)
- **Default Font**: Monaco 10pt for ASCII output display
- **Preferences**: Saves width/height settings in NSUserDefaults

## Common Development Tasks
- **Adding New Features**: Extend MainController categories or create new ones
- **Modifying ASCII Algorithm**: Edit `stringForBrightness()` function in NSImage+ASCII.m
- **UI Changes**: Edit MainMenu.xib in Interface Builder
- **Localization**: Add new .lproj directories and corresponding strings files
- **Icon Updates**: Replace files in Images/ directory and update project references

## File Locations Reference
```
ASCIIConverter.xcodeproj/     # Xcode project configuration
├── project.pbxproj           # Project build settings
└── project.xcworkspace/      # Workspace configuration

Source Files (13 total, ~559 lines):
├── main.m                    # Application entry point
├── MainController.{h,m}      # Primary controller
├── MainController+*.{h,m}    # Controller categories
├── NSImage+ASCII.{h,m}       # Core conversion logic
├── ASCIIImageView.{h,m}      # Custom image view
└── ASCIIConverter_Prefix.pch # Precompiled header

Resources:
├── English.lproj/            # English localization
│   ├── MainMenu.xib         # Main interface
│   └── Localizable.strings  # UI strings
├── zh_TW.lproj/             # Traditional Chinese
├── Images/                   # Icons and toolbar images
└── Info.plist              # Application metadata
```

## Debugging and Development Tips
- **Memory Management**: Uses ARC (Automatic Reference Counting)
- **Key Classes**: MainController, ASCIIImageView, NSImage+ASCII category
- **Main Flow**: Image drag → ASCIIImageView delegate → MainController convert → NSImage+ASCII → Display
- **Performance**: ASCII conversion is CPU-intensive for large images; size limits prevent performance issues
- **UI Framework**: Uses Interface Builder (.xib) with outlet connections
- **Always check MainController.m after modifying UI connections in MainMenu.xib**
- **Test on multiple image formats**: PNG, JPEG, GIF, TIFF all supported via NSImage

## Troubleshooting
- **Build Failures**: Ensure Xcode Command Line Tools are installed: `xcode-select --install`
- **Missing Icons**: Verify Images/ directory files are included in project bundle resources
- **Localization Issues**: Check .strings file syntax and encoding (UTF-8)
- **UI Layout Problems**: Verify outlet connections in Interface Builder
- **Performance Issues**: Check image size limits in validation code (max 200x200)

## Documentation Files
- **README.markdown** - English documentation with build instructions
- **README.zh_TW.markdown** - Traditional Chinese documentation
- **screenshot.png** - Application screenshot showing drag-and-drop interface
- **LICENSE** - License information

## Repository Metadata
- **License**: Specified in LICENSE file
- **Version**: 0.1 (from Info.plist CFBundleVersion)
- **Author**: zonble (Weizhong Yang)
- **Contact**: zonble@gmail.com
- **Languages**: Objective-C (Cocoa), Interface Builder
- **Minimum Deployment**: macOS 10.9
- **Repository Structure**: Single Xcode project with 13 source files (~559 total lines)