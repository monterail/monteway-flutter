import 'package:template/src/repositories/user_repository/src/abstract_user_repository.dart';
import 'package:template/src/services/hive.dart';
import 'models/models.dart';

class UserRepository with IHiveRepository<User> implements IUserRepository {
  @override
  String get boxKey => 'userInfoBoxKey';

  @override
  Future<User?> getUser(String userKey) async {
    return (await box).get(userKey);
  }

  @override
  Future<void> saveUser(String userKey, User user) async {
    await (await box).put(userKey, user);
  }

  @override
  Future<void> deleteUser(String userKey, User user) async {
    await (await box).delete(userKey);
  }
}
