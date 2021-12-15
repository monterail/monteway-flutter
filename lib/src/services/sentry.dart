import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> configureSentry(SentryFlutterOptions options) async {
  // Set tracesSampleRate to 1.0 to capture 100% of transactions
  // for performance monitoring.
  // Consider adjusting this value in production.
  options.tracesSampleRate = 1.0;
}

// Make Sentry API testable.
abstract class SentryIntegration {
  Future<SentryId> captureException(
    dynamic throwable, {
    dynamic stackTrace,
    dynamic hint,
    ScopeCallback? withScope,
  });
}

class SentryClient implements SentryIntegration {
  @override
  Future<SentryId> captureException(
    throwable, {
    stackTrace,
    hint,
    ScopeCallback? withScope,
  }) =>
      Sentry.captureException(
        throwable,
        stackTrace: stackTrace,
        hint: hint,
        withScope: withScope,
      );
}

class SentryBlocObserver extends BlocObserver {
  final SentryIntegration _sentry;

  SentryBlocObserver({required SentryIntegration sentryIntegration})
      : _sentry = sentryIntegration;

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    _sentry.captureException(
      error,
      stackTrace: stackTrace,
      hint: bloc.toString(),
    );
    super.onError(bloc, error, stackTrace);
  }
}
