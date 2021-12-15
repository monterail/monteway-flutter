part of 'main_screen_bloc.dart';

abstract class MainScreenEvent extends Equatable {
  const MainScreenEvent();

  @override
  List<Object> get props => [];
}

class InitEvent extends MainScreenEvent {}

class AddUserEvent extends MainScreenEvent {}

class RemoveUserEvent extends MainScreenEvent {}

class ReportSentryError extends MainScreenEvent {}
