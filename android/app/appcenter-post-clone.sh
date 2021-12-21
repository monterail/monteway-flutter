   #!/usr/bin/env bash
#Place this script in project/android/app/

cd ..

# fail if any command fails
set -e
# debug log
set -x

cd ..
git clone -b beta https://github.com/flutter/flutter.git
export PATH=`pwd`/flutter/bin:$PATH

flutter channel stable
flutter doctor

echo "Installed flutter to `pwd`/flutter"

flutter pub get
make generate-code

# build APK
make build-prod-apk

# copy the APK where AppCenter will find it
mkdir -p android/app/build/outputs/apk/; mv build/app/outputs/flutter-apk/app-release.apk $_

# if you need build bundle (AAB) in addition to your APK, uncomment line below and last line of this script.
make build-prod-appbundle

# copy the AAB where AppCenter will find it
mkdir -p android/app/build/outputs/bundle/; mv build/app/outputs/bundle/release/app-release.aab $_