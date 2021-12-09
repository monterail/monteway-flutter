import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'src/app.dart';

void main() async => await SentryFlutter.init(
      (options) {
        // Set tracesSampleRate to 1.0 to capture 100% of transactions
        //for performance monitoring.
        // Consider adjusting this value in production.
        options.tracesSampleRate = 1.0;
      },
      appRunner: () => runApp(const MyApp()),
    );
