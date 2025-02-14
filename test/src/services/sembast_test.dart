import 'package:flutter_test/flutter_test.dart';
import 'package:sembast/sembast_memory.dart';
import 'package:template/src/repositories/user_repository/user_repository.dart';

void main() {
  late Database database;
  late StoreRef<String, Map<String, dynamic>> store;

  setUp(() async {
    // In memory factory for unit test
    final factory = newDatabaseFactoryMemory();
    database = await factory.openDatabase('test.db');
    store = stringMapStoreFactory.store('userStore');
  });

  tearDown(() async {
    await database.close();
  });

  group('Sembast Database with User model', () {
    const userKey = 'user1';
    final user = User(
      pk: 1,
      email: 'test@example.com',
      phone: '123456789',
      firstName: 'John',
      lastName: 'Doe',
    );

    test('should save and retrieve a user', () async {
      await store.record(userKey).put(database, user.toJson());
      final retrievedData = await store.record(userKey).get(database);
      final retrievedUser =
          retrievedData != null ? User.fromJson(retrievedData) : null;

      expect(retrievedUser, isNotNull);
      expect(retrievedUser?.pk, user.pk);
      expect(retrievedUser?.email, user.email);
      expect(retrievedUser?.phone, user.phone);
      expect(retrievedUser?.firstName, user.firstName);
      expect(retrievedUser?.lastName, user.lastName);
    });

    test('should return null for non-existent user', () async {
      final retrievedData = await store
          .record('non_existent_user')
          .get(database);
      expect(retrievedData, isNull);
    });

    test('should delete a user', () async {
      await store.record(userKey).put(database, user.toJson());
      var retrievedData = await store.record(userKey).get(database);
      expect(retrievedData, isNotNull);

      await store.record(userKey).delete(database);
      retrievedData = await store.record(userKey).get(database);

      expect(retrievedData, isNull);
    });
  });
}
