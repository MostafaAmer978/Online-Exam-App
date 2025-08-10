import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/features/login/domain/entities/user_model.dart';

abstract class LoginRemoteDataSource {
  Future<ApiResult<UserModel>> login({String? email, String? password});
}
