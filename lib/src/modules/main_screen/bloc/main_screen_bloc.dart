import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_type/result_type.dart';
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
    final result = await userRepository.getUser('userKey');
    final _ = switch (result) {
      Success(value: final user) =>
        user != null
            ? emit(MainScreenState.loaded(user))
            : emit(const MainScreenState.initial()),
      Failure(value: final error) => emit(
        MainScreenState.error(error.errorType),
      ),
    };
  }

  Future<void> _saveUser(
    AddUserEvent event,
    Emitter<MainScreenState> emit,
  ) async {
    emit(const MainScreenState.loading());
    final user = const User(pk: 1, firstName: 'Jan', lastName: 'Nowak');
    final result = await userRepository.saveUser('userKey', user);
    final _ = switch (result) {
      Success(value: final _) => emit(MainScreenState.loaded(user)),
      Failure(value: final error) => emit(
        MainScreenState.error(error.errorType),
      ),
    };
  }

  Future<void> _removeUser(
    RemoveUserEvent event,
    Emitter<MainScreenState> emit,
  ) async {
    emit(const MainScreenState.loading());
    final result = await userRepository.deleteUser('userKey');
    final _ = switch (result) {
      Success(value: final _) => emit(const MainScreenState.initial()),
      Failure(value: final error) => emit(
        MainScreenState.error(error.errorType),
      ),
    };
  }

  void _handleReportSentryError(
    ReportSentryError event,
    Emitter<MainScreenState> emit,
  ) {
    throw Exception('test exception');
  }
}
