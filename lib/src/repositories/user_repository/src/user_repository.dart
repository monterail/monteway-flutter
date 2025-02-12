import 'package:sembast/sembast.dart';
import 'package:template/src/repositories/user_repository/user_repository.dart';
import 'package:template/src/services/sembast.dart';

class UserRepository implements IUserRepository {
  static const String _storeName = 'userStore';
  final StoreRef<String, Map<String, dynamic>> _store =
      stringMapStoreFactory.store(_storeName);

  @override
  Future<User?> getUser(String userKey) async {
    final record = await _store.record(userKey).get(database);
    return record != null ? User.fromJson(record) : null;
  }

  @override
  Future<void> saveUser(String userKey, User user) async =>
      _store.record(userKey).put(database, user.toJson());

  @override
  Future<void> deleteUser(String userKey) async =>
      _store.record(userKey).delete(database);
}
