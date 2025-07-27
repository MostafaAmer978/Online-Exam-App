class UserModel {
   final String userId;
   final String username;
   String? token;

  UserModel({required this.userId, required this.username, required this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['_id'],
      username: json['username'],
      token: json['token'],
    );
  }
}
