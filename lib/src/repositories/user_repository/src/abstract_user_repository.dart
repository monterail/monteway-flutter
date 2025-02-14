import 'package:result_type/result_type.dart';

import 'models/models.dart';

abstract class IUserRepository {
  Future<Result<User?, Exception>> getUser(String userKey);
  Future<Result<void, Exception>> saveUser(String userKey, User user);
  Future<Result<void, Exception>> deleteUser(String userKey);
}
