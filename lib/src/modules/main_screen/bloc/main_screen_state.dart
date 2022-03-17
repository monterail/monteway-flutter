part of 'main_screen_bloc.dart';

@autoequalMixin
class MainScreenState extends Equatable with _$MainScreenStateAutoequalMixin {
  final User? user;
  const MainScreenState({
    this.user,
  });
}

class InitState extends MainScreenState {}
