import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/services/hive.dart';
import 'package:template/src/services/sentry.dart';
import 'package:sentry_flutter/sentry_flutter.dart' hide SentryClient;

import 'src/app.dart';

Future<void> main() => bootWithSentry();

Future<void> boot() async {
  await setupHive();
  runApp(MyApp());
}

Future<void> bootWithSentry() async {
  await setupHive();
  return SentryFlutter.init(
    configureSentry,
    appRunner: () {
      Bloc.observer = SentryBlocObserver(
        sentryIntegration: SentryClient(),
      );
      runApp(MyApp());
    },
  );
}
