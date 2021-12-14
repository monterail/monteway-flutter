import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:template/src/repositories/user_repository/user_repository.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(InitState()) {
    on<InitEvent>(_init);
    on<AddUserEvent>(_saveUser);
    on<RemoveUserEvent>(_removeUser);
  }

  void _init(InitEvent event, Emitter<MainState> emit) {
    try {
      final user = UserRepository?.getUser();
      emit(MainState(user: user));
    } catch (_) {}
  }

  void _saveUser(AddUserEvent event, Emitter<MainState> emit) {
    final user = User(pk: 1, firstName: 'Jan', lastName: 'Nowak');
    try {
      UserRepository?.saveUser(user);
      emit(MainState(user: user));
    } catch (_) {}
  }

  void _removeUser(RemoveUserEvent event, Emitter<MainState> emit) {
    try {
      if (UserRepository?.getUser() != null) {
        UserRepository?.deleteUser(UserRepository.getUser()!);
        emit(const MainState());
      }
    } catch (_) {}
  }
}
