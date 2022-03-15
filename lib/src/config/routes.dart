import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:template/src/config/routes/bloc.dart';
import 'package:template/src/config/routes/cubit.dart';
import 'package:template/src/config/routes/main.dart';

part 'routes.gr.dart';

class Routes {
  static const main = MainRouteHelper();
  static const bloc = BlocRouteHelper();
  static const cubit = CubitRouteHelper();
}

@AdaptiveAutoRouter(routes: [
  AutoRoute(
    page: MainRouteHelper.widget,
    path: MainRouteHelper.path,
    initial: true,
  ),
  AutoRoute(page: BlocRouteHelper.widget, path: BlocRouteHelper.path),
  AutoRoute(page: CubitRouteHelper.widget, path: CubitRouteHelper.path)
])
class AppRouter extends _$AppRouter {}
