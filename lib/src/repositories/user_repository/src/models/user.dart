import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  int pk;
  @HiveField(1)
  String? email;
  @HiveField(2)
  String? phone;
  @HiveField(3)
  String? firstName;
  @HiveField(4)
  String? lastName;

  User({
    required this.pk,
    this.email,
    this.phone,
    this.firstName,
    this.lastName,
  });

  String getFullName() => '$firstName $lastName';
}
