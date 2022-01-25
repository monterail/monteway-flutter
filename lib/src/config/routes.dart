import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:template/src/modules/bloc_screen/view/bloc_view.dart';
import 'package:template/src/modules/cubit_screen/view/cubit_view.dart';
import 'package:template/src/modules/main_screen/view/main_screen_view.dart';

part 'routes.gr.dart';

class Routes {
  // Routes without params
  static const main = '/';

  // Routes with params
  static String blocRoute({String? title}) => '/bloc/${title ?? ':title'}';
  static String cubitRoute({String? title}) => '/cubit/${title ?? ':title'}';
}

@AdaptiveAutoRouter(routes: [
  AutoRoute(page: MainScreenWidget, initial: true),
  AutoRoute(page: BlocView, path: '/bloc/:title'),
  AutoRoute(page: CubitView, path: '/cubit/:title')
])
class AppRouter extends _$AppRouter {}
