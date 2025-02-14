part of 'main_screen_bloc.dart';

@freezed
class MainScreenState with _$MainScreenState {
  const factory MainScreenState.initial() = InitialState;
  const factory MainScreenState.loading() = LoadingState;
  const factory MainScreenState.loaded(User user) = LoadedState;
  const factory MainScreenState.error(MainScreenErrorType errorType) =
      ErrorState;
}

enum MainScreenErrorType { fetchError, saveError, deleteError }

extension MainScreenStateX on MainScreenErrorType {
  String get translatedError => switch (this) {
    MainScreenErrorType.fetchError => 'Failed to fetch user',
    MainScreenErrorType.saveError => 'Failed to save user',
    MainScreenErrorType.deleteError => 'Failed to delete user',
  };
}
