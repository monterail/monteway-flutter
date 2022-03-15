import 'package:flutter/foundation.dart';

@immutable
abstract class RouteHelper<ParameterType> {
  final String parent;
  final String _path;
  const RouteHelper({required String path, this.parent = ''}) : _path = path;
  String get absolutePath => '$parent/$_path'.replaceAll('//', '/');
  String generatePath(ParameterType parameter);
  @override
  String toString() => absolutePath;
}

@immutable
abstract class ParameterlessRouteHelper {
  final String parent;
  final String _path;
  const ParameterlessRouteHelper({required String path, this.parent = ''})
      : _path = path;
  String get absolutePath => '$parent/$_path'.replaceAll('//', '/');
  String generatePath() => absolutePath;
  @override
  String toString() => absolutePath;
}
