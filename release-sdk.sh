#!/bin/sh

# Author : Lorenzo Limoli
# Script follows here:

WORKSPACE=TestApp
SCHEME=SdkA
FOLDER=archives
DEPENDENCIES=($SCHEME)

if [ ! -d "./$FOLDER" ];
then
    mkdir $FOLDER
fi

xcodebuild archive -workspace ./$WORKSPACE.xcworkspace -scheme $SCHEME -destination generic/platform="iOS" -archivePath ./$FOLDER/$SCHEME-iphoneos.xcarchive SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild archive -workspace ./$WORKSPACE.xcworkspace -scheme $SCHEME -destination generic/platform="iOS Simulator" -archivePath ./$FOLDER/$SCHEME-iphonesimulator.xcarchive SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES

#for d in ${DEPENDENCIES[@]}; do
#    xcodebuild -create-xcframework \
#    -framework ./$FOLDER/$SCHEME-iphoneos.xcarchive/Products/Library/Frameworks/$d.framework \
#    -framework ./$FOLDER/$SCHEME-iphonesimulator.xcarchive/Products/Library/Frameworks/$d.framework \
#    -output ./$FOLDER/$SCHEME.xcframework
#done

xcodebuild -create-xcframework \
-framework ./$FOLDER/$SCHEME-iphoneos.xcarchive/Products/Library/Frameworks/$SCHEME.framework \
-framework ./$FOLDER/$SCHEME-iphonesimulator.xcarchive/Products/Library/Frameworks/$SCHEME.framework \
-output ./$FOLDER/$SCHEME.xcframework