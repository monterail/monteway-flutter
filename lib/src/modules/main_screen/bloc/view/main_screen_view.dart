import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:template/src/config/routes.dart';
import 'package:template/src/modules/main_screen/bloc/main_bloc.dart';
import 'package:template/src/environment/variables.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:template/src/repositories/user_repository/user_repository.dart';

class MainScreenWidget extends StatelessWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

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
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainBloc(userRepository: UserRepository()),
      child: Scaffold(
        body: Center(
          child: BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
              if (state is InitState) {
                context.read<MainBloc>().add(InitEvent());
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
                    onPressed: _reportError,
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
                  Text(state.user?.getFullName() ?? '-'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () =>
                            context.read<MainBloc>().add(RemoveUserEvent()),
                        child: const Text('Remove'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<MainBloc>().add(AddUserEvent()),
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
