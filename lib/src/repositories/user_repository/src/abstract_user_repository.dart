import 'package:hive/hive.dart';
import 'models/models.dart';

abstract class IUserRepository {
  Box getUserBox(String userInfoBoxKey);

  User? getUser(Box box, String userKey);

  Future<void> saveUser(Box box, String userKey, User user);

  Future<void> deleteUser(Box box, String userKey, User user);
}
