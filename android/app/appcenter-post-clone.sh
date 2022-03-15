#!/usr/bin/env bash
#Place this script in project/android/app/

cd ..

# fail if any command fails
set -e
# debug log
set -x

cd ..
git clone -b stable https://github.com/flutter/flutter.git
export PATH=`pwd`/flutter/bin:$PATH

flutter precache
flutter doctor

echo "Installed flutter to `pwd`/flutter"

flutter pub get
make generate-code

# build APK
if [ "$RELEASE_TARGET" == "development" ]; then
  make build-dev-apk
else
  make build-prod-apk
fi

# copy the APK where AppCenter will find it
mkdir -p android/app/build/outputs/apk/; mv build/app/outputs/flutter-apk/app-release.apk $_

# build bundle (AAB) in addition to your APK
if [ "$RELEASE_TARGET" == "development" ]; then
  make build-dev-appbundle
else
  make build-prod-appbundle
fi

# copy the AAB where AppCenter will find it
mkdir -p android/app/build/outputs/bundle/; mv build/app/outputs/bundle/release/app-release.aab $_