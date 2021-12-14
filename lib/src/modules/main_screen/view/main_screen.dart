import 'package:flutter/material.dart';
import 'package:template/src/environment/variables.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:routemaster/routemaster.dart';
import 'package:template/src/config/routes.dart';
import 'package:template/src/modules/main_screen/bloc/main_screen_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

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
                onPressed: () =>
                    context.read<MainScreenBloc>().add(ReportSentryError()),
                label: const Text('Report an error to Sentry'),
                icon: const Icon(Icons.error),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () => Routemaster.of(context).push(
                      Routes.cubitRoute(title: 'Cubit'),
                    ),
                    child: const Text('To cubit screen'),
                  ),
                  TextButton(
                    onPressed: () => Routemaster.of(context).push(
                      Routes.blocRoute(title: 'BLoC'),
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
