part of 'main_screen_bloc.dart';

abstract class MainScreenEvent extends Equatable {
  const MainScreenEvent();

  @override
  List<Object?> get props => [];
}

@autoequalMixin
class InitEvent extends MainScreenEvent with _$InitEventAutoequalMixin {}

@autoequalMixin
class AddUserEvent extends MainScreenEvent with _$AddUserEventAutoequalMixin {}

@autoequalMixin
class RemoveUserEvent extends MainScreenEvent
    with _$RemoveUserEventAutoequalMixin {}

@autoequalMixin
class ReportSentryError extends MainScreenEvent
    with _$ReportSentryErrorAutoequalMixin {}
