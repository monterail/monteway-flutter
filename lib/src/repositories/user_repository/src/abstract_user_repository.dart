import 'models/models.dart';

abstract class IUserRepository {
  Future<User?> getUser(String userKey);

  Future<void> saveUser(String userKey, User user);

  Future<void> deleteUser(String userKey, User user);
}
