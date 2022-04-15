# 🚀 Monterail Flutter app template 🚀

Flutter app template.

Supports:

- [x] Internationalization
- [x] Splash screen
- [x] Linting and formatting
- [x] State management with bloc
- [x] Flavors
- [x] Routing
- [x] Testing
- [x] CI/CD with AppCenter
- [x] Setup for VS Code
- [x] Sentry integration
- [x] ADR
- [x] Changelog
- [x] Caching, saving local data

## 👋 Getting Started

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

By default [auto_route](https://pub.dev/packages/auto_route) is used as route management. It provides us opportunity to easily send params to our routes.

### Add a route with parameter

To create a route with a parameter:

1. Add a `RouteHelper` class in `lib/src/config/routes/` directory with defined parameter:

```dart
import 'package:template/src/config/routes/routes.dart';
import 'package:template/src/modules/bloc_screen/view/bloc_view.dart';
export 'package:template/src/modules/bloc_screen/view/bloc_view.dart';

class BlocRouteHelper extends RouteHelper<String> {
  static const path = '/bloc/:title';
  static const widget = BlocView;

  const BlocRouteHelper() : super(path: path);

  @override
  String generatePath(String title) =>
      absolutePath.replaceFirst(':title', title);
}
```

> **Be sure to export the widget file.**

2. Annotate parameter in the target widget's constructor

```dart
class ParamView extends StatelessWidget {
  final String? title;
  const BlocView({@PathParam('title') this.title, Key? key}) : super(key: key);
  ...
```

3. Add the route helper to `Routes` (`lib/src/config/routes.dart`) class

```dart
class Routes {
  // ...
  static const bloc = BlocRouteHelper();
  // ...
}
```

4. Let `auto_route` know about the new route

```dart
@AdaptiveAutoRouter(routes: [
  // ...
  AutoRoute(page: BlocRouteHelper.widget, path: BlocRouteHelper.path),
  // ...
])
class AppRouter extends _$AppRouter {}
```

5. Run `make generate-code` to make the new route available in the app.

### Add a route without parameter

To create a route without any parameters:

1. Add a `ParameterlessRouteHelper` class in `lib/src/config/routes/` directory:

```dart
import 'package:template/src/config/routes/routes.dart';
import 'package:template/src/modules/main_screen/view/main_screen_view.dart';
export 'package:template/src/modules/main_screen/view/main_screen_view.dart';

class MainRouteHelper extends ParameterlessRouteHelper {
  static const path = '/';
  static const widget = MainScreenWidget;
  const MainRouteHelper() : super(path: path);
}
```

> **Be sure to export the widget file.**

2. Add the route helper to `Routes` (`lib/src/config/routes.dart`) class

```dart
class Routes {
  // ...
  static const main = MainRouteHelper();
  // ...
}
```

3. Let `auto_route` know about the new route

```dart
@AdaptiveAutoRouter(routes: [
  // ...
  AutoRoute(page: MainRouteHelper.widget, path: MainRouteHelper.path),
  // ...
])
class AppRouter extends _$AppRouter {}
```

4. Run `make generate-code` to make the new route available in the app.

## 📈 Sentry

After creating Sentry project just pass the DSN to `--dart-define=SENTRY_DSN=value` in `.vscode/launch.json` or when running a `flutter run/build` commands.

[Sentry docs](https://docs.sentry.io/platforms/flutter/)

## 📆 Changelog

Each app version should have brief notes for introduced changes in `CHANGELOG.md`.

## 📒 Caching, saving local data

We use [Hive](https://docs.hivedb.dev/#/) database to store data locally. Hive is a lightweight, powerful database which runs fast on the device. 
Unless you absolutely need to model your data with many relationships, choosing this pure-Dart package with no native dependencies can be the best option. 
Hive is centered around the idea of `boxes`. `Box` has to be opened before use. In addition to the plain-flavored Boxes, 
there are also options which support lazy-loading of values and encryption.

### Initilization

Hive needs to be ​initialized​ to, among other things, know in which directory it stores the data. A service for hive was created. 
The `setupHive` method initializes hive for flutter and registers adapters and is called in `main`. 
`IHiveRepository<E>` is an mixin that manages Hive box opening, where `E` is a specific type depending on the type of data being stored. 

Hive service
```dart
Future<void> setupHive() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  _registerAdapters();
}

void _registerAdapters() {
  Hive.registerAdapter<User>(UserAdapter());
}

abstract class IHiveRepository<E> {
  Box<E>? _box;

  String get boxKey;

  Future<Box<E>> get box async {
    _box ??= await Hive.openBox<E>(boxKey);
    return _box!;
  }
}
```

### Boxes

Data can be stored and read only from an opened `Box`. Opening a `Box` loads all of its data from the local storage into memory for immediate access.

1. Open box
```dart
Hive.openBox('userBox');
```
2. Get an already opened instance
```dart
Hive.box('name');
```
There are two basic options of adding data - either call `put(key, value)` and specify the key yourself, 
or call `add` and utilize Hive's auto-incrementing keys. Unless you absolutely need to define the keys manually, 
calling add is the better and simpler option.
```dart
userBox.add(User('Test User', 28));
```

#### TypeAdapter

Hive works with binary data. While it's entirely possible to write a custom adapter which fumbles with a ​​​​​BinaryWriter and a BinaryReader, 
it's much easier to let the ​`hive_generator`​ package do the hard job for you. Making an adapter for specific class is then as simple as adding a few annotations.

Creating a TypeAdapter
```dart
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType()
class User {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int age;

  User(this.name, this.age);
}
```
To generate TypeAdapter you should run `flutter packages pub run build_runner build`. Thanks to the `Makefile` scripts, we can do this with `make generate-code`
`make watch-and-generate-code` until stopped will watch for file changes and automatically build code if necessary. 
It's useful when dealing with a lot of code generation since it'll do a whole project build only at start and then do smaller builds only for affected files.
The created adapter must be registered.

### Repositories

`IHiveRepository` should be used with every repository that is using Hive.

Example
```dart
class UserRepository with IHiveRepository<User> implements IUserRepository {
  @override
  String get boxKey => 'userInfoBoxKey';

  @override
  Future<User?> getUser(String userKey) async {
    return (await box).get(userKey);
  }

  @override
  Future<void> saveUser(String userKey, User user) async {
    await (await box).put(userKey, user);
  }

  @override
  Future<void> deleteUser(String userKey) async {
    await (await box).delete(userKey);
  }
```
#### Dependency injection

Dependency injection is an object-oriented technique that sends the dependencies of another object to an object. Using dependency injection, 
we can also move the creation and restriction of dependent objects outside the classes. This concept brings a more significant level of adaptability, decoupling, and simpler testing.
Famous packages for DI:

1. [ioc](https://pub.dev/packages/ioc#-readme-tab-)
2. [get_it ](https://pub.dev/packages/get_it)

## 🏭 Building the app

There is a `Makefile` with build scripts for _dev_ and _prod_ environment (those are standard `flutter build *` commands but with environment variables).

Eg. to build _dev_ `.apk` run `make build-dev-apk`. For iOS there're `*-ipa`, and for web there're `*-web` scripts.

## 🏎💨 CD with AppCenter

We're using custom scripts to make [AppCenter](https://appcenter.ms/) support our app building process.

There's one for Android (`android/app/appcenter-post-clone.sh`) and one for iOS (`ios/appcenter-post-clone.sh`). Those download latest stable Flutter and build _prod_ flavored app with signing.

> To build the _dev_ flavored app, set a RELEASE_TARGET environment variable to `development` in branch build configuration.

### Android setup

Firstly, create a keystore for signing.

You need to have [Java installed](https://openjdk.java.net/) and available in the shell:

- on mac, using [brew](https://brew.sh/): `brew install openjdk`,
- on windows, just download a `.msi` file [from here](https://www.microsoft.com/openjdk),
- on linux or wsl, there's probably `openjdk` available in your package manager.

In the root project folder run: `make create-android-signing`.
You will be asked some questions, but the passwords are the most important. Remember those and put
in `android/app/build.gradle` in section `signingConfigs`:

```gradle
signingConfigs {
    release {
        storeFile rootProject.file("upload-keystore.jks") # leave as-is
        storePassword "password" # put your store password here
        keyAlias "upload" # leave as-is
        keyPassword "password" # put your key password here
    }
}
```

To check if signing works, you can run `make build-prod-apk`. If the build process goes fine
and the app is working it's done 🍾

#### AppCenter Android setup

To use signing in Android builds, set the AppCenter build like so:

<img width="466" alt="image" src="https://user-images.githubusercontent.com/15102395/154212761-1ea57fa3-9cc9-4e92-b665-b22a25ecb180.png">

> To distribute the app automatically to the store, follow [this guide](https://docs.microsoft.com/en-us/appcenter/distribution/stores/googleplay).

### iOS setup

iOS builds will require `.mobileprovision` and `.p12` files. [Here's](https://docs.microsoft.com/en-us/appcenter/build/ios/code-signing) how to obtain them. Keep them somewhere safe and upload copies to AppCenter build config:

<img width="465" alt="Screenshot 2021-12-13 at 12 44 10" src="https://user-images.githubusercontent.com/15102395/145806541-104509d2-f81c-44bc-96f8-d53445557dd2.png">

#### AppCenter iOS setup

To use signing in iOS builds, set the AppCenter build like so:

<img width="465" alt="Screenshot 2021-12-13 at 12 40 22" src="https://user-images.githubusercontent.com/15102395/145806568-aa100b39-3ad9-4aec-bfa2-765e20785cf4.png">

## 🤖 Automatic lint, format and tests on PR

To enable automated code quality tests, head to `.github/workflows/lint-and-test-pr.yml` and uncomment lines:

```yml
on:
  pull_request:
    branches:
      - development
```

It's off by default to not slow down development, but if your project have 3+ developers
working on it, turning it on may be beneficial.

## 🧪 Testing

Testing of Flutter goes into three categories:

- unit tests for single function, class or method,
- widget tests for a single widget,
- integration tests for whole app or big part of the app.

Example tests can be found in `test/` directory.

### BLoC

Strive to **test every BLoC** thoroughly as it is the source of data for UI
and a recipient of events from the system. If it works, then UI will likely work too
as it listens closely for updates, and requested actions will take place.

Example test:

```dart
blocTest<CounterBloc, CounterState>(
  'decrease actions',
  build: () => CounterBloc(),
  act: (bloc) => [for (int i = 0; i < 4; i++) bloc.add(CounterDecreased())],
  expect: () => const <CounterState>[
    CounterState(value: -1),
    CounterState(value: -2),
    CounterState(value: -3),
    CounterState(value: -4)
  ],
);
```

Use `blocTest` to reduce boilerplate compared to classic tests, where managing
instances is required.

### Widgets

When creating reusable widget, **DO** test if it's params do affect the UI as expected.

Testing complex widgets, like whole pages should be done via integration tests.

### Integration tests

Consider implementing integration tests for crucial workflows, eg. logging in.
Avoid implementing integration tests for every workflow as updating an app
fortified with a lot of integration tests will be difficult. Assume that
reusable widgets are working correctly (as those are tested) and focus
integration tests on workflow interactions.

Look at [Flutter integration testing docs](https://docs.flutter.dev/cookbook/testing/integration/introduction).

We're keeping integration tests in `integration_test` directory.

To run integration tests, use `make run-integration-test`.

## 🍾 Starting new project

Perform this checklist: [Template using checklist](doc/template-start-checklist.md).
