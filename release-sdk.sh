#!/bin/sh

# Author : Lorenzo Limoli
# Script follows here:

WORKSPACE=TestApp
SCHEME=SdkA
FOLDER=archives
DEPENDENCIES=($SCHEME SdkB SwiftDate libPhoneNumber_iOS)

if [ ! -d "./$FOLDER" ];
then
    mkdir $FOLDER
fi

xcodebuild archive -workspace ./$WORKSPACE.xcworkspace -scheme $SCHEME -destination generic/platform="iOS" -archivePath ./$FOLDER/$SCHEME-iphoneos.xcarchive SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild archive -workspace ./$WORKSPACE.xcworkspace -scheme $SCHEME -destination generic/platform="iOS Simulator" -archivePath ./$FOLDER/$SCHEME-iphonesimulator.xcarchive SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES

cmd="xcodebuild -create-xcframework"
for d in ${DEPENDENCIES[@]}; do
    cmd+=" -framework ./$FOLDER/$SCHEME-iphoneos.xcarchive/Products/Library/Frameworks/$d.framework"
done

for d in ${DEPENDENCIES[@]}; do
    cmd+=" -framework ./$FOLDER/$SCHEME-iphonesimulator.xcarchive/Products/Library/Frameworks/$d.framework"
done



cmd+=" -output ./$FOLDER/$SCHEME.xcframework"

$cmd