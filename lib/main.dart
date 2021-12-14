import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart' hide SentryClient;
import 'package:template/src/services/sentry.dart';

import 'src/app.dart';

Future<void> main() => bootWithSentry();

void boot() => runApp(const MyApp());

Future<void> bootWithSentry() => SentryFlutter.init(
      configureSentry,
      appRunner: () {
        BlocOverrides.runZoned(
          () => runApp(const MyApp()),
          blocObserver: SentryBlocObserver(
            sentryIntegration: SentryClient(),
          ),
        );
      },
    );
