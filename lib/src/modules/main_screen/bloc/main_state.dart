part of 'main_bloc.dart';

class MainState extends Equatable {
  final User? user;
  const MainState({
    this.user,
  });

  @override
  List<Object?> get props => [user];
}

class InitState extends MainState {}
