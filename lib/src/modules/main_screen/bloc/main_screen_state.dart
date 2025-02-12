part of 'main_screen_bloc.dart';

@freezed
class MainScreenState with _$MainScreenState {
  const factory MainScreenState.initial() = InitialState;
  const factory MainScreenState.loading() = LoadingState;
  const factory MainScreenState.loaded(User user) = LoadedState;
  const factory MainScreenState.error(String message) = ErrorState;
}
