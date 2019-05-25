#!/bin/sh
cd "`dirname "$0"`"
ADB=
if [ "$ANDROID_HOME" != "" ]; then ADB=$ANDROID_HOME/platform-tools/adb; else ADB=/media/scad/WD1003FZEX_1TB/Epic_Games/NVPACK/android-sdk-linux//platform-tools/adb; fi
DEVICE=
if [ "$1" != "" ]; then DEVICE="-s $1"; fi
echo
echo Uninstalling existing application. Failures here can almost always be ignored.
$ADB $DEVICE uninstall net.scadsdnd.BCruze_UE4
echo
echo Removing old data. Failures here are usually fine - indicating the files were not on the device.
$ADB $DEVICE shell 'rm -r $EXTERNAL_STORAGE/UE4Game/BCruze_UE4'
$ADB $DEVICE shell 'rm -r $EXTERNAL_STORAGE/UE4Game/UE4CommandLine.txt'
$ADB $DEVICE shell 'rm -r $EXTERNAL_STORAGE/obb/net.scadsdnd.BCruze_UE4'
$ADB $DEVICE shell 'rm -r $EXTERNAL_STORAGE/Android/obb/net.scadsdnd.BCruze_UE4'
echo
echo Uninstall completed
exit 0
