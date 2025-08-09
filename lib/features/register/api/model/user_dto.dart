import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam_app/features/register/domain/entities/user_entity.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDTO {
  @JsonKey(name: "username")
  final String? username;

  @JsonKey(name: "firstName")
  final String? firstName;

  @JsonKey(name: "lastName")
  final String? lastName;

  @JsonKey(name: "email")
  final String? email;

  @JsonKey(name: "phone")
  final String? phone;

  @JsonKey(name: "role")
  final String? role;

  @JsonKey(name: "isVerified")
  final bool? isVerified;

  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "createdAt")
  final String? createdAt;

  UserDTO({
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.role,
    this.isVerified,
    this.id,
    this.createdAt,
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UserDTOToJson(this);

  RegisterEntity toRegisterEntity() => RegisterEntity(
    username: username ?? '',
    firstName: firstName ?? '',
    lastName: lastName ?? '',
    email: email ?? '',
    phone: phone ?? '',
  );
}
