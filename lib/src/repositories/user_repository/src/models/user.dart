import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required int pk,
    String? email,
    String? phone,
    String? firstName,
    String? lastName,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}

extension UserX on User {
  String getFullName() => '${firstName ?? ''} ${lastName ?? ''}'.trim();
}
