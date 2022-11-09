#!/bin/sh

# Author : Lorenzo Limoli
# Script follows here:

WORKSPACE=TestApp
SCHEME=SdkA
FOLDER=static-output
STATIC_LIB=SdkBStatic
CONFIG=Release

if [ -d "./$FOLDER" ];
then
    rm -rf $FOLDER
fi

mkdir $FOLDER

xcodebuild build \
  -workspace $WORKSPACE.xcworkspace \
  -scheme $SCHEME \
  -derivedDataPath derived_data \
  -arch x86_64 \
  -sdk iphonesimulator \
  -configuration $CONFIG
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES
mkdir -p $FOLDER/simulators
cp -r derived_data/Build/Products/$CONFIG-iphonesimulator/ $FOLDER/simulators

xcodebuild build \
  -workspace $WORKSPACE.xcworkspace \
  -scheme $SCHEME \
  -derivedDataPath derived_data \
  -arch arm64 \
  -sdk iphoneos \
  -configuration $CONFIG
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES
mkdir -p $FOLDER/simulators
cp -r derived_data/Build/Products/$CONFIG-iphoneos/ $FOLDER/devices

rm -rf derived_data

xcodebuild -create-xcframework \
  -framework $FOLDER/simulators/$SCHEME.framework \
  -framework $FOLDER/devices/$SCHEME.framework \
  -output $FOLDER/$SCHEME.xcframework