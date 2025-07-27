import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam_app/features/login/domain/entities/user_model.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDTO {
  @JsonKey(name: "_id")
  final String? id;
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
  @JsonKey(name: "createdAt")
  final String? createdAt;

  UserDTO({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.role,
    this.isVerified,
    this.createdAt,
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return _$UserDTOFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserDTOToJson(this);
  }

  UserModel toUserModel() {
    return UserModel(userId: id ?? "", username: username ?? "" , token: "");
  }
}
