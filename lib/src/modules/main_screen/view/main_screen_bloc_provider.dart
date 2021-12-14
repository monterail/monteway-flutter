import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/modules/main_screen/bloc/main_screen_bloc.dart';
import 'package:template/src/services/sentry.dart';

class MainScreenBlocProvider extends StatelessWidget {
  final Widget child;

  const MainScreenBlocProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => MainScreenBloc(sentryIntegration: SentryClient()),
        child: child,
      );
}
