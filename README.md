# Monterail Flutter app template

Flutter app template.

Supports:

[x] Internationalization
[x] Splash screen
[x] Linting and formatting
[ ] State management with bloc
[ ] Flavors
[ ] Routing
[ ] Testing
[ ] CI/CD with AppCenter
[ ] Setup for VS Code
[ ] Sentry integration
[ ] ADR
[ ] Changelog
[ ] Caching, saving local data

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
 ![vs code linting](https://trello.com/1/cards/61b0844bf5dc81690e9a4ea3/attachments/61b1a114d4df848f628380f7/download/image.png)

> To see issues next to affected line use [Error Lens](https://marketplace.visualstudio.com/items?itemName=usernamehw.errorlens) extension.

##### Auto-formatting on file save

Enable automatic code formatting on each file save by settings `Manage (Bottom left cog icon) ➡ Settings`, then search for _Editor: Format On Save_ and enable the checkbox:

![vs code formatting](https://trello.com/1/cards/61b0844bf5dc81690e9a4ea3/attachments/61b1a39c9cf9c21fffcc1c7c/download/image.png)
