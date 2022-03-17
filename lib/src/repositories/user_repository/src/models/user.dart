import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@autoequalMixin
@HiveType(typeId: 1)
class User extends Equatable with _$UserAutoequalMixin {
  @HiveField(0)
  final int pk;
  @HiveField(1)
  final String? email;
  @HiveField(2)
  final String? phone;
  @HiveField(3)
  final String? firstName;
  @HiveField(4)
  final String? lastName;

  User({
    required this.pk,
    this.email,
    this.phone,
    this.firstName,
    this.lastName,
  });

  String getFullName() => '$firstName $lastName';
}
