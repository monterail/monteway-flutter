import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:template/src/environment/variables.dart';

Future<void> configureSentry(SentryFlutterOptions options) async {
  // Set tracesSampleRate to 1.0 to capture 100% of transactions
  // for performance monitoring.
  // Consider adjusting this value in production.
  options
    ..tracesSampleRate = 1.0
    ..dsn = EnvironmentVariables.sentryDsn;
}

// Make Sentry API testable.
abstract class SentryIntegration {
  Future<SentryId> captureException(
    dynamic throwable, {
    dynamic stackTrace,
    Hint? hint,
    FutureOr<void> Function(Scope)? withScope,
  });
}

class SentryClient implements SentryIntegration {
  @override
  Future<SentryId> captureException(
    throwable, {
    stackTrace,
    hint,
    ScopeCallback? withScope,
  }) => Sentry.captureException(
    throwable,
    stackTrace: stackTrace,
    hint: hint,
    withScope: withScope,
  );
}

class SentryBlocObserver extends BlocObserver {
  SentryBlocObserver({required SentryIntegration sentryIntegration})
    : _sentry = sentryIntegration;
  final SentryIntegration _sentry;

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    final hint = Hint()..addAll({'bloc': bloc.toString()});

    _sentry.captureException(error, stackTrace: stackTrace, hint: hint);
    super.onError(bloc, error, stackTrace);
  }
}
