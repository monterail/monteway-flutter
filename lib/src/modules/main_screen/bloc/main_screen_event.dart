part of 'main_screen_bloc.dart';

@freezed
class MainScreenEvent with _$MainScreenEvent {
  const factory MainScreenEvent.init() = InitEvent;
  const factory MainScreenEvent.addUser() = AddUserEvent;
  const factory MainScreenEvent.removeUser() = RemoveUserEvent;
  const factory MainScreenEvent.reportSentryError() = ReportSentryError;
}
