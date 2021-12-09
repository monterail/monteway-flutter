class EnvironmentVariables {
  static const String appName = String.fromEnvironment(
    'APP_NAME',
    defaultValue: 'Unflavored app name',
  );
  static const String appSuffix = String.fromEnvironment('APP_SUFFIX');
}
