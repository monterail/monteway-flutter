import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/config/routes.dart';
import 'package:template/src/localization/app_localizations.dart';
import 'package:template/src/modules/main_screen/bloc/main_screen_bloc.dart';
import 'package:template/src/environment/variables.dart';
import 'package:template/src/repositories/user_repository/user_repository.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create:
        (context) =>
            MainScreenBloc(userRepository: UserRepository())
              ..add(const InitEvent()),
    child: Scaffold(
      body: Center(
        child: BlocBuilder<MainScreenBloc, MainScreenState>(
          builder:
              (context, state) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.appTitle,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const Text(
                    '${EnvironmentVariables.appName} ${EnvironmentVariables.appSuffix}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 16),
                  state.when(
                    initial:
                        () => Column(
                          children: [const Text('-'), _actionButtons(context)],
                        ),
                    loading: () => const CircularProgressIndicator(),
                    loaded:
                        (user) => Column(
                          children: [
                            Text(
                              user.getFullName(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            _actionButtons(context),
                          ],
                        ),
                    error:
                        (message) => Column(
                          children: [
                            Text(
                              message.translatedError,
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            _actionButtons(context),
                          ],
                        ),
                  ),
                  const SizedBox(height: 20),
                  TextButton.icon(
                    onPressed:
                        () => context.read<MainScreenBloc>().add(
                          const ReportSentryError(),
                        ),
                    icon: const Icon(Icons.error, color: Colors.red),
                    label: const Text('Report an error to Sentry'),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed:
                            () =>
                                context.router.push(CubitRoute(title: 'Cubit')),
                        child: const Text('To Cubit screen'),
                      ),
                      TextButton(
                        onPressed:
                            () => context.router.push(BlocRoute(title: 'BLoC')),
                        child: const Text('To BLoC screen'),
                      ),
                    ],
                  ),
                  TextButton(
                    child: const Text('Licences'),
                    onPressed: () => showLicensePage(context: context),
                  ),
                ],
              ),
        ),
      ),
    ),
  );

  Widget _actionButtons(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ElevatedButton(
        onPressed:
            () => context.read<MainScreenBloc>().add(const RemoveUserEvent()),
        child: const Text('Remove'),
      ),
      const SizedBox(width: 16),
      ElevatedButton(
        onPressed:
            () => context.read<MainScreenBloc>().add(const AddUserEvent()),
        child: const Text('Add'),
      ),
    ],
  );
}
