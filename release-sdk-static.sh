#!/bin/sh

# Author : Lorenzo Limoli
# Script follows here:

WORKSPACE=TestApp
SCHEME=SdkA
FOLDER=static-output
STATIC_LIB=SdkBStatic

if [ ! -d "./$FOLDER" ];
then
    mkdir $FOLDER
fi

xcodebuild build \
  -workspace $WORKSPACE.xcworkspace \
  -scheme $SCHEME \
  -derivedDataPath derived_data \
  -arch x86_64 \
  -sdk iphonesimulator \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES
mkdir -p $FOLDER/simulators
cp -r derived_data/Build/Products/Debug-iphonesimulator/ $FOLDER/simulators

xcodebuild build \
  -workspace $WORKSPACE.xcworkspace \
  -scheme $SCHEME \
  -derivedDataPath derived_data \
  -arch arm64 \
  -sdk iphoneos \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES
mkdir -p $FOLDER/simulators
cp -r derived_data/Build/Products/Debug-iphonesimulator/ $FOLDER/devices

xcodebuild -create-xcframework \
  -framework $FOLDER/simulators/$SCHEME.framework \
  -framework $FOLDER/devices/$SCHEME.framework \
  -output $FOLDER/$SCHEME.xcframework