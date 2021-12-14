import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:template/src/modules/bloc_screen/view/bloc_view.dart';
import 'package:template/src/modules/cubit_screen/view/cubit_view.dart';
import 'package:template/src/modules/main_screen/view/main_screen.dart';
import 'package:template/src/modules/main_screen/view/main_screen_bloc_provider.dart';

class Routes {
  // Routes without params
  static const main = '/';

  // Routes with params
  static String blocRoute({String? title}) => '/bloc/${title ?? ':title'}';
  static String cubitRoute({String? title}) => '/cubit/${title ?? ':title'}';

  // Route map
  static final routes = RouteMap(
    routes: {
      main: (_) => const MaterialPage(
            child: MainScreenBlocProvider(
              child: MainScreen(),
            ),
          ),
      blocRoute(): (info) => MaterialPage(
            child: BlocView(
              title: info.pathParameters['title'],
            ),
          ),
      cubitRoute(): (info) => MaterialPage(
            child: CubitView(
              title: info.pathParameters['title'],
            ),
          ),
    },
  );
}
