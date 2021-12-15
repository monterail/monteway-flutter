// This is an example Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
//
// Visit https://flutter.dev/docs/cookbook/testing/widget/introduction for
// more information about Widget testing.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  group('MyWidget', () {
    testWidgets('should display a localized text', (WidgetTester tester) async {
      // Define a Widget
      final myWidget = MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
        ],
        home: Builder(builder: (context) {
          return Text(AppLocalizations.of(context)!.appTitle);
        }),
      );

      // Build myWidget and trigger a frame.
      await tester.pumpWidget(myWidget);

      // Verify myWidget shows some text
      expect(find.byType(Text), findsWidgets);
    });
  });
}
