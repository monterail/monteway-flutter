import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:template/src/config/routes.dart';
import 'package:template/src/environment/variables.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routerDelegate: RoutemasterDelegate(
          routesBuilder: (context) => Routes.routes,
        ),
        routeInformationParser: const RoutemasterParser(),
        // Providing a restorationScopeId allows the Navigator built by the
        // MaterialApp to restore the navigation stack when a user leaves and
        // returns to the app after it has been killed while running in the
        // background.
        restorationScopeId: 'app',

        // Provide the generated AppLocalizations to the MaterialApp. This
        // allows descendant Widgets to display the correct translations
        // depending on the user's locale.
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // English, no country code
        ],

        // Use AppLocalizations to configure the correct application title
        // depending on the user's locale.
        //
        // The appTitle is defined in .arb files found in the localization
        // directory.
        onGenerateTitle: (BuildContext context) =>
            AppLocalizations.of(context)!.appTitle,

        // Define a light and dark color theme. Then, read the user's
        // preferred ThemeMode (light, dark, or system default) from the
        // SettingsController to display the correct theme.
        theme: ThemeData(),
      );
}

class TheScreenWidget extends StatelessWidget {
  const TheScreenWidget({Key? key}) : super(key: key);

  Future<void> _reportError() async {
    try {
      throw Exception('test exception');
    } catch (e, stackTrace) {
      await Sentry.captureException(
        e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)!.appTitle,
              ),
              const Text(
                '${EnvironmentVariables.appName} ${EnvironmentVariables.appSuffix}',
              ),
              TextButton.icon(
                onPressed: _reportError,
                label: const Text('Report an error to Sentry'),
                icon: const Icon(Icons.error),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () => Routemaster.of(context).push(
                      Routes.cubitView('Cubit'),
                    ),
                    child: const Text('To cubit screen'),
                  ),
                  TextButton(
                    onPressed: () => Routemaster.of(context).push(
                      Routes.blocView('BLoC'),
                    ),
                    child: const Text('To BLoC screen'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
