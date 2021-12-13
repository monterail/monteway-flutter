# 🚀 Monterail Flutter app template 🚀

Flutter app template.

Supports:

- [x] Internationalization
- [x] Splash screen
- [x] Linting and formatting
- [x] State management with bloc
- [x] Flavors
- [x] Routing
- [ ] Testing
- [ ] CI/CD with AppCenter
- [ ] Setup for VS Code
- [x] Sentry integration
- [ ] ADR
- [x] Changelog
- [ ] Caching, saving local data

## 👋 Getting Started

This project is a starting point for a Flutter application that follows the
[simple app state management
tutorial](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple).

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## 📦 Assets

The `assets` directory houses images, fonts, and any other files you want to
include with your application.

The `assets/images` directory contains [resolution-aware
images](https://flutter.dev/docs/development/ui/assets-and-images#resolution-aware).

### Native splash screen

Splash screen configuration with available options is available in `flutter_native_splash.yaml`.
Any changes to this file have to be followed by running `flutter pub run flutter_native_splash:create` command.

> This is a solution for masking the initial load time of Flutter engine. If the app does
> something time consuming before displaying meaningful content to the user consider
> adding a splash screen widget to mask such wait time.

## 🌍 Localization

We're using `flutter_localizations` package which generates code automatically based on `lib/src/localization/*.arb` language files.

### Supporting new languages

To add another language to the app:

1. add a `app_xx.arb` where _xx_ is a two letter language code (eg. pl for Polish, es for Spanish). It must contain translated strings for all keys from `app_en.arb` (except ones with a `@` prefix, those are for added context for the translator),
2. add new supported Locale to `supportedLocales` list in `lib/app.dart` (eg. `Locale('pl', '')` for Polish, `Locale('es', '')` for Spanish).

### Using defined strings

After code generation all of the defined strings will be available for widgets from `AppLocalizations.of(context)`.
Eg. to read an `appTitle` field in the Text widget: `Text(AppLocalizations.of(context)!.appTitle)`.

#### Testing with `AppLocalizations`

If a widget to test uses `AppLocalizations`, you will have to wrap it with `MaterialApp` and provide `localizationsDelegates: AppLocalizations.delegate` like so:

```dart
const myWidget = MaterialApp(
  localizationsDelegates: [
    AppLocalizations.delegate,
  ],
  home: TestWidget(),
);
```

- Flutter docs: [link](https://docs.flutter.dev/development/accessibility-and-localization/internationalization)

## 💅 Code style

It's good to keep consistent code style, at least project-wide, and Dart/Flutter does come with linting support.

### Linting

We're using `flutter_lints` package which contains recommended rules for Flutter apps.

Run linting by running `flutter analyze` command in the root of the project or integrate linter with your IDE.

### Formatting

To format the code use `flutter format lib/` or `flutter format test/` command in the root of a project.

#### Usage with VS Code

Linting can be easily integrated via [Flutter](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter) extension.

With this extension, you can find analysis issues in the **Problems** tab:
 ![VS Code linting](https://user-images.githubusercontent.com/15102395/145346960-faba586f-a99e-4e5c-85c2-e6e3117fc163.png)

> To see issues next to affected line use [Error Lens](https://marketplace.visualstudio.com/items?itemName=usernamehw.errorlens) extension.

##### Auto-formatting on file save

Enable automatic code formatting on each file save by settings `Manage (Bottom left cog icon) ➡ Settings`, then search for _Editor: Format On Save_ and enable the checkbox:

![VS Code formatting](https://user-images.githubusercontent.com/15102395/145347010-71f4e765-2247-424a-a712-56d3d5fe37f8.png)

## 🚄 BLoC state management

We're using bloc (mostly) as out state management. It provides us easy separation of our apps into three layers:
1. Presentation (your UI has to be located here)
2. Business logic (here is place for code that do some stuff)
3. Data (work with network or local data will be located here)

### BLoC or Cubit?

We use both Cubit and classic BLoC.

BLoC is your choice if you are building a feature that has inputs, a lot of fetches, or any other kind of complicated states

If you are working on some simpler stuff, take a Cubit. You can easily rewrite it later.

### Useful tips

* Install [this](https://marketplace.visualstudio.com/items?itemName=FelixAngelov.bloc) VSCode extension to save your time while you're creating your blocs
* Separate your models, API fetches, UI screens, and blocs/cubits by features
* Write tests for each of your bloc/cubit
* Your states and events have to extend [Equatable](https://pub.dev/packages/equatable), the reason is described [here](https://stackoverflow.com/a/67827047) (if you're lazy) and [here](https://medium.com/flutterworld/flutter-equatable-its-use-inside-bloc-7d14f3b5479b) (if you're not so lazy)
* Put only one [BlocProvider](https://pub.dev/documentation/flutter_bloc/latest/flutter_bloc/BlocProvider-class.html) in the tree, then just use [BlocBuilder](https://pub.dev/documentation/flutter_bloc/latest/flutter_bloc/BlocBuilder-class.html) to have access to your bloc or cubit
* If your bloc contains some work with streams, don't forget to close it in [close()](https://pub.dev/documentation/bloc/latest/bloc/Bloc/close.html) method of your bloc
* **Do** use [MultiBlocProvider](https://pub.dev/documentation/flutter_bloc/latest/flutter_bloc/MultiBlocProvider-class.html) in case you need to provide more than one bloc to your module

## ⚙️ Environment variables (flavors)

This template supports flavoring via environment variables passed to `flutter build/run` commands.

Variables are available to other modules in `lib/src/environment/variables.dart` and any new ones should be added there.

### Adding environment variables

Each variable should have an `APP_` prefix to avoid accidental overriding of other tool variables.

To add a new variable:

1. Add a new `--dart-define=APP_VARIABLE=value` parameter to `flutter build/run` command or `.vscode/launch.json`, like so:

```shell
flutter run --dart-define=APP_VARIABLE=value
```

2. Handle the variable in the code. In `lib/src/environment/variables.dart` add a new field that will read value from environment, like so:

```dart
class EnvironmentVariables {
  // ...
  static const String appVariable = String.fromEnvironment('APP_VARIABLE', defaultValue: 'default');
  // ...
}
```

3. (Optional) Handle the value in Android build process. Head to `android/app/build.gradle` and add your variable to `dartEnvironmentVariables`, like so:

```gradle
def dartEnvironmentVariables = [
    // ...
    APP_VARIABLE: 'default'
    // ...
];
```

4. (Optional) Handle the value in iOS build process. New variables will be automatically available for use in Xcode (as long as those are prefixed with `APP_`).

### Adding environments

To create new environment:

1. Create new file with variables in `environment/` directory.
2. Include new variables file in `Makefile`.
3. Create build scripts for the new flavor.

Also, for VS Code:

1. Open `.vscode/launch.json`.
2. Create _debug_ and _profile_ launch modes with new environment variables.

## 🧭 Routing

By default [Routemaster](https://pub.dev/packages/routemaster) is used as route management. it provides us opportunity to easily send params to our routes.

To create some route without params:

1. Define path as a static constant
```dart
  static const main = '/';
```
2. Add pair of your path and widget to routes map
```dart
RouteMap(
  routes: {
    main: (_) => const MaterialPage(child: TheScreenWidget()),
    },
  );
```

To create route with some parameter:

1. Define path as static method that has named parameters.
```dart
  static String cubitRoute({String? title}) => '/cubit/${title ?? ':title'}';
```
2. Add pair to routes map
```dart
RouteMap(
  routes: {
    // Defined path is '/cubit/:title'
    cubitRoute(): (info) => MaterialPage(
      child: CubitView(
        title: info.pathParameters['title'],
        ),
      ),
    },
  );
```

To send some parameters to the screen:
```dart
Routemaster.of(context).push(Routes.cubitRoute('BLoC'));
```

You also can use your route without parameters, in this case, the provided value will be `null`

## 📈 Sentry

After creating Sentry project just pass the DSN to `--dart-define=SENTRY_DSN=value` in `.vscode/launch.json` or when running a `flutter run/build` commands.

[Sentry docs](https://docs.sentry.io/platforms/flutter/)

## 📆 Changelog

Each app version should have brief notes for introduced changes in `CHANGELOG.md`.

## 🏭 Building the app

There is a `Makefile` with build scripts for _dev_ and _prod_ environment (those are standard `flutter build *` commands but with environment variables).

Eg. to build _dev_ `.apk` run `make build-dev-apk`. For iOS there're `*-ipa`, and for web there're `*-web` scripts.
