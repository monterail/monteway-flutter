#!/usr/bin/env bash
#Place this script in project/ios/

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

if [ "$RELEASE_TARGET" == "development" ]; then
  make build-dev-ios
else
  make build-prod-ios
fi
