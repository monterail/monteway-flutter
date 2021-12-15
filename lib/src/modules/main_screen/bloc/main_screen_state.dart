part of 'main_screen_bloc.dart';

class MainScreenState extends Equatable {
  final User? user;
  const MainScreenState({
    this.user,
  });

  @override
  List<Object?> get props => [user];
}

class InitState extends MainScreenState {}
