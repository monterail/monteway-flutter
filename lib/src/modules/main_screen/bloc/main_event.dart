part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class InitEvent extends MainEvent {}

class AddUserEvent extends MainEvent {}

class RemoveUserEvent extends MainEvent {}
