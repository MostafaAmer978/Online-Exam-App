import 'package:json_annotation/json_annotation.dart';
import 'user_dto.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "token")
  final String? token;

  @JsonKey(name: "user")
  final UserDTO? user;

  RegisterResponse({this.message, this.token, this.user});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}
