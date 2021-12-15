import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:template/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'tap counter increment twice, and expect 2 as a result',
    (tester) async {
      // Use .boot() instead of .main() since Sentry wrapper breaks
      // Flutter's ability to probe current app state.
      await app.boot();
      await tester.pumpAndSettle();

      final blocRouteButton = find.widgetWithText(
        TextButton,
        'To BLoC screen',
      );

      await tester.tap(blocRouteButton);
      await tester.pumpAndSettle();

      final addButton = find.widgetWithIcon(FloatingActionButton, Icons.add);

      await tester.tap(addButton);
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      expect(find.text('2'), findsOneWidget);
    },
  );
}
