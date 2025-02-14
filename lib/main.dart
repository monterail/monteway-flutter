import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/services/sembast.dart';
import 'package:template/src/services/sentry.dart';
import 'package:sentry_flutter/sentry_flutter.dart' hide SentryClient;

import 'src/app.dart';

void main() async => runZonedGuarded(
  () async {
    await bootWithSentry();
  },
  (error, stackTrace) {
    Sentry.captureException(error, stackTrace: stackTrace);
  },
);

Future<void> boot() async {
  await setupSembast();
  runApp(MyApp());
}

Future<void> bootWithSentry() async {
  await setupSembast();
  await SentryFlutter.init(
    configureSentry,
    appRunner: () {
      Bloc.observer = SentryBlocObserver(sentryIntegration: SentryClient());
      runApp(MyApp());
    },
  );
}
