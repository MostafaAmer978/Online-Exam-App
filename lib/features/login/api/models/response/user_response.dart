import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam_app/features/login/api/models/user_dto.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "token")
  final String? token;
  @JsonKey(name: "user")
  final UserDTO? user;

  UserResponse ({
    this.message,
    this.token,
    this.user,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return _$UserResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserResponseToJson(this);
  }
}




