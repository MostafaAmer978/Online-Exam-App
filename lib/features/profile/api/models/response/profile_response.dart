import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam_app/features/login/api/models/user_dto.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "user")
  final UserDTO? user;

  ProfileResponse ({
    this.message,
    this.user,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return _$ProfileResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProfileResponseToJson(this);
  }
}
