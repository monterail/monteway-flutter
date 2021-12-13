import 'package:hive/hive.dart';
import 'models/models.dart';

class UserRepository {
  static const _userKey = 'userKey';
  static const userInfoBoxKey = 'userInfoBoxKey';

  static Box get _userInfoBox => Hive.box(userInfoBoxKey);

  static User? getUser() => _userInfoBox.get(_userKey);

  static Future<void> saveUser(User user) async =>
      await _userInfoBox.put(_userKey, user);

  static Future<void> deleteUser(User user) async =>
      await _userInfoBox.delete(_userKey);
}
