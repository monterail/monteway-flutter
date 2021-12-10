import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:template/src/app.dart';
import 'package:template/src/modules/bloc_screen/view/bloc_view.dart';
import 'package:template/src/modules/cubit_screen/view/cubit_view.dart';

class Routes {
  // Routes without params
  static const main = '/';

  // Routes with params
  static String blocView([String? title]) => '/bloc/${title ?? ':title'}';
  static String cubitView([String? title]) => '/cubit/${title ?? ':title'}';

  // Route map
  static final routes = RouteMap(
    routes: {
      main: (_) => const MaterialPage(child: TheScreenWidget()),
      blocView(): (info) => MaterialPage(
            child: BlocView(
              title: info.pathParameters['title'],
            ),
          ),
      cubitView(): (info) => MaterialPage(
            child: CubitView(
              title: info.pathParameters['title'],
            ),
          ),
    },
  );
}
