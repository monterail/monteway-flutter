import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/config/routes.dart';
import 'package:template/src/modules/main_screen/bloc/main_screen_bloc.dart';
import 'package:template/src/environment/variables.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:template/src/repositories/user_repository/user_repository.dart';

class MainScreenWidget extends StatelessWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainScreenBloc(userRepository: UserRepository()),
      child: Scaffold(
        body: Center(
          child: BlocBuilder<MainScreenBloc, MainScreenState>(
            builder: (context, state) {
              if (state is InitState) {
                context.read<MainScreenBloc>().add(InitEvent());
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.appTitle,
                  ),
                  const Text(
                    '${EnvironmentVariables.appName} ${EnvironmentVariables.appSuffix}',
                  ),
                  TextButton.icon(
                    onPressed: () => context.read<MainScreenBloc>().add(
                          ReportSentryError(),
                        ),
                    label: const Text('Report an error to Sentry'),
                    icon: const Icon(Icons.error),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () => context.router.pushNamed(
                          Routes.cubit.generatePath('Cubit'),
                        ),
                        child: const Text('To cubit screen'),
                      ),
                      TextButton(
                        onPressed: () => context.router.pushNamed(
                          Routes.bloc.generatePath('BLoC'),
                        ),
                        child: const Text('To BLoC screen'),
                      ),
                    ],
                  ),
                  Text(state.user?.getFullName() ?? '-'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => context
                            .read<MainScreenBloc>()
                            .add(RemoveUserEvent()),
                        child: const Text('Remove'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<MainScreenBloc>().add(AddUserEvent()),
                        child: const Text('Add'),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
