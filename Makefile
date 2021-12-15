include environment/.dev-variables
include environment/.prod-variables

# Development builds
.PHONY: build-dev
dev:
	flutter $(FLUTTER_METHOD) $(BUILD_TARGET) \
		--dart-define=APP_NAME="${APP_NAME_DEV}" \
		--dart-define=APP_SUFFIX=${APP_SUFFIX_DEV} \
		--dart-define=SENTRY_DSN=${SENTRY_DSN_DEV} \
		--dart-define=SENTRY_ENVIRONMENT=${SENTRY_ENVIRONMENT_DEV} \
		$(OPTIONS)

.PHONY: run-dev
run-dev:
	FLUTTER_METHOD=run make dev

.PHONY: build-dev
build-dev:
	FLUTTER_METHOD=build make dev

.PHONY: build-dev-apk
build-dev-apk:
	BUILD_TARGET=apk make build-dev

.PHONY: build-dev-appbundle
build-dev-appbundle:
	BUILD_TARGET=appbundle make build-dev

.PHONY: build-dev-ios
build-dev-ios:
	BUILD_TARGET=ios OPTIONS="--no-codesign" make build-dev

.PHONY: build-dev-ipa
build-dev-ipa:
	BUILD_TARGET=ipa make build-dev

.PHONY: build-dev-web
build-dev-web:
	BUILD_TARGET=web make build-dev

# Production builds
.PHONY: prod
prod:
	flutter $(FLUTTER_METHOD) $(BUILD_TARGET) \
		--dart-define=APP_NAME="${APP_NAME_PROD}" \
		--dart-define=SENTRY_DSN=${SENTRY_DSN_PROD} \
		--dart-define=SENTRY_ENVIRONMENT=${SENTRY_ENVIRONMENT_PROD} \
		$(OPTIONS)

.PHONY: run-prod
run-prod:
	FLUTTER_METHOD=run make prod OPTIONS="--release --verbose"

.PHONY: build-prod
build-prod:
	FLUTTER_METHOD=build make prod

.PHONY: build-prod-apk
build-prod-apk:
	BUILD_TARGET=apk make build-prod

.PHONY: build-prod-appbundle
build-prod-appbundle:
	BUILD_TARGET=appbundle make build-prod

.PHONY: build-prod-ios
build-prod-ios:
	BUILD_TARGET=ios OPTIONS="--no-codesign" make build-prod

.PHONY: build-prod-ipa
build-prod-ipa:
	BUILD_TARGET=ipa make build-prod

.PHONY: build-prod-web
build-prod-web:
	BUILD_TARGET=web make build-prod

# Tests
.PHONY: test
test:
	flutter test \
		--dart-define=APP_NAME="Test app" \
		--dart-define=SENTRY_DSN=value \
		--dart-define=APP_SUFFIX=.test \
		--dart-define=SENTRY_ENVIRONMENT=test \
		$(TEST_DIR)

.PHONY: run-tests
run-tests:
	make test

.PHONY: run-integration-tests
run-integration-tests:
	TEST_DIR=integration_test make test

# Code generation
.PHONY: generate-code
generate-code:
	flutter packages pub run build_runner build --delete-conflicting-outputs

.PHONY: watch-and-generate-code
watch-and-generate-code:
	flutter packages pub run build_runner watch --delete-conflicting-outputs

# Helpers
.PHONY: create-android-signing
create-android-signing:
	keytool -genkey -v -keystore android/upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload

.PHONY: update-splashscreen
update-splashscreen:
	flutter pub run flutter_native_splash:create