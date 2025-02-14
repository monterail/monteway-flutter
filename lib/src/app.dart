import 'package:flutter/material.dart';
import 'package:template/src/config/routes.dart';
import 'package:template/src/localization/app_localizations.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _router = AppRouter();

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    routerConfig: _router.config(
      navRestorationScopeId:
          // Providing a navRestorationScopeId allows the Navigator built by the
          // router to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          'app',
    ),

    // Provide the generated AppLocalizations to the MaterialApp. This
    // allows descendant Widgets to display the correct translations
    // depending on the user's locale.
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,

    // Use AppLocalizations to configure the correct application title
    // depending on the user's locale.
    //
    // The appTitle is defined in .arb files found in the localization
    // directory.
    onGenerateTitle:
        (BuildContext context) => AppLocalizations.of(context)!.appTitle,

    theme: ThemeData(),
  );
}
