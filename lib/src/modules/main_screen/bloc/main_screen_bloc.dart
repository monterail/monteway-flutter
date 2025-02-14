import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:template/src/repositories/user_repository/user_repository.dart';

part 'main_screen_event.dart';
part 'main_screen_state.dart';
part 'main_screen_bloc.freezed.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  MainScreenBloc({required this.userRepository})
    : super(const MainScreenState.initial()) {
    on<InitEvent>(_init);
    on<AddUserEvent>(_saveUser);
    on<RemoveUserEvent>(_removeUser);
    on<ReportSentryError>(_handleReportSentryError);
  }
  final UserRepository userRepository;

  Future<void> _init(InitEvent event, Emitter<MainScreenState> emit) async {
    emit(const MainScreenState.loading());
    try {
      final user = await userRepository.getUser('userKey');
      if (user != null) {
        emit(MainScreenState.loaded(user));
      } else {
        emit(const MainScreenState.initial());
      }
    } catch (e) {
      emit(const MainScreenState.error('Błąd pobierania użytkownika'));
    }
  }

  Future<void> _saveUser(
    AddUserEvent event,
    Emitter<MainScreenState> emit,
  ) async {
    emit(const MainScreenState.loading());
    try {
      final user = User(pk: 1, firstName: 'Jan', lastName: 'Nowak');
      await userRepository.saveUser('userKey', user);
      emit(MainScreenState.loaded(user));
    } catch (e) {
      emit(const MainScreenState.error('Błąd zapisywania użytkownika'));
    }
  }

  Future<void> _removeUser(
    RemoveUserEvent event,
    Emitter<MainScreenState> emit,
  ) async {
    emit(const MainScreenState.loading());
    try {
      await userRepository.deleteUser('userKey');
      emit(const MainScreenState.initial());
    } catch (e) {
      emit(const MainScreenState.error('Błąd usuwania użytkownika'));
    }
  }

  void _handleReportSentryError(
    ReportSentryError event,
    Emitter<MainScreenState> emit,
  ) {
    throw Exception('test exception');
  }
}
