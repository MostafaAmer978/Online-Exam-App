class UserModel {
   final String userId;
   final String username;

  UserModel({required this.userId, required this.username,});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['_id'],
      username: json['username'],
    );
  }
}
