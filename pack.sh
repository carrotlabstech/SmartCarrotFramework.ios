#!/bin/sh

# --------------------------------------
# BUILD PLATFORM SPECIFIC Frameworks
# *** Currently is not in use, makes sense to start using once XCFrameworks support nested embedded frameworks. ***
# --------------------------------------

# Clean old builds
/bin/rm -fr ./build/*

# iOS Devices
xcodebuild archive -scheme SmartCarrotFramework -archivePath "./build/ios.device" -sdk iphoneos SKIP_INSTALL=NO
# iOS Simulator
xcodebuild archive -scheme SmartCarrotFramework -archivePath "./build/ios.simulator" -sdk iphonesimulator SKIP_INSTALL=NO

# --------------------------------------
# PACKAGE Framework
# --------------------------------------
xcodebuild -create-xcframework \
    -framework "./build/ios.device.xcarchive/Products/Library/Frameworks/SmartCarrotFramework.framework" \
    -framework "./build/ios.simulator.xcarchive/Products/Library/Frameworks/SmartCarrotFramework.framework" \
    -output "./build/SmartCarrotFramework.xcframework"