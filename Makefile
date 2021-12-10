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
		--dart-define=APP_SUFFIX=${APP_SUFFIX_PROD} \
		--dart-define=SENTRY_DSN=${SENTRY_DSN_PROD} \
		--dart-define=SENTRY_ENVIRONMENT=${SENTRY_ENVIRONMENT_PROD} \
		$(OPTIONS)

.PHONY: run-prod
run-prod:
	FLUTTER_METHOD=run make prod

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