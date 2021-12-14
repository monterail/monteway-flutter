import 'package:hive/hive.dart';
import 'package:template/src/repositories/user_repository/src/abstract_user_repository.dart';
import 'models/models.dart';

class UserRepository implements IUserRepository {
  @override
  Box getUserBox(String userInfoBoxKey) {
    return Hive.box(userInfoBoxKey);
  }

  @override
  User? getUser(Box box, String userKey) {
    return box.get(userKey);
  }

  @override
  Future<void> saveUser(Box box, String userKey, User user) async {
    await box.put(userKey, user);
  }

  @override
  Future<void> deleteUser(Box box, String userKey, User user) async {
    await box.delete(userKey);
  }
}
