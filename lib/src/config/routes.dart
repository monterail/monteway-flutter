import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:template/src/modules/bloc_screen/view/bloc_screen.dart';
import 'package:template/src/modules/cubit_screen/view/cubit_screen.dart';
import 'package:template/src/modules/main_screen/view/main_screen.dart';

part 'routes.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      page: MainRoute.page,
      path: '/',
      initial: true,
    ),
    AutoRoute(page: BlocRoute.page, path: '/bloc/:title'),
    AutoRoute(page: CubitRoute.page, path: '/cubit/:title')
  ];
}
