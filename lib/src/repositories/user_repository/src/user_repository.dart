import 'package:result_type/result_type.dart';
import 'package:sembast/sembast.dart';
import 'package:template/src/modules/main_screen/bloc/main_screen_bloc.dart';
import 'package:template/src/repositories/user_repository/user_repository.dart';
import 'package:template/src/services/sembast.dart';

class UserRepository implements IUserRepository {
  static const String _storeName = 'userStore';
  final StoreRef<String, Map<String, dynamic>> _store = stringMapStoreFactory
      .store(_storeName);

  @override
  Future<Result<User?, UserRepositoryException>> getUser(String userKey) async {
    try {
      final record = await _store.record(userKey).get(database);
      return Success(record != null ? User.fromJson(record) : null);
    } catch (e) {
      return Failure(UserRepositoryException(MainScreenErrorType.fetchError));
    }
  }

  @override
  Future<Result<void, UserRepositoryException>> saveUser(
    String userKey,
    User user,
  ) async {
    try {
      await _store.record(userKey).put(database, user.toJson());
      return Success(null);
    } catch (e) {
      return Failure(UserRepositoryException(MainScreenErrorType.saveError));
    }
  }

  @override
  Future<Result<void, UserRepositoryException>> deleteUser(
    String userKey,
  ) async {
    try {
      await _store.record(userKey).delete(database);
      return Success(null);
    } catch (e) {
      return Failure(UserRepositoryException(MainScreenErrorType.deleteError));
    }
  }
}

class UserRepositoryException implements Exception {
  UserRepositoryException(this.errorType);

  final MainScreenErrorType errorType;
}
