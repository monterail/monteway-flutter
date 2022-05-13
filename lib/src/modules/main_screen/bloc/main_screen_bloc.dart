import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/repositories/user_repository/user_repository.dart';

part 'main_screen_bloc.g.dart';
part 'main_screen_event.dart';
part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  final UserRepository userRepository;

  MainScreenBloc({required this.userRepository}) : super(InitState()) {
    on<InitEvent>(_init);
    on<AddUserEvent>(_saveUser);
    on<RemoveUserEvent>(_removeUser);
    on<ReportSentryError>(_handleReportSentryError);
  }

  Future<void> _init(InitEvent event, Emitter<MainScreenState> emit) async {
    final user = await userRepository.getUser('userKey');
    emit(MainScreenState(user: user));
  }

  Future<void> _saveUser(
    AddUserEvent event,
    Emitter<MainScreenState> emit,
  ) async {
    final user = User(pk: 1, firstName: 'Jan', lastName: 'Nowak');
    await userRepository.saveUser('userKey', user);
    emit(MainScreenState(user: user));
  }

  Future<void> _removeUser(
    RemoveUserEvent event,
    Emitter<MainScreenState> emit,
  ) async {
    final user = await userRepository.getUser('userKey');
    if (user != null) {
      await userRepository.deleteUser('userKey', user);
      emit(const MainScreenState());
    }
  }

  void _handleReportSentryError(
    ReportSentryError event,
    Emitter<MainScreenState> emit,
  ) {
    // This exception will be noted by global bloc observer,
    // implemented in `services/sentry.dart`.
    throw Exception('test exception');
  }
}
