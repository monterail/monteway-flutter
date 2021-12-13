import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:template/src/repositories/user_repository/src/user_repository.dart';
import 'src/app.dart';
import 'src/repositories/user_repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _hiveSetup();
  await SentryFlutter.init(
    (options) {
      // Set tracesSampleRate to 1.0 to capture 100% of transactions
      //for performance monitoring.
      // Consider adjusting this value in production.
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(const MyApp()),
  );
}

Future<void> _hiveSetup() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox(UserRepository.userInfoBoxKey);
}
