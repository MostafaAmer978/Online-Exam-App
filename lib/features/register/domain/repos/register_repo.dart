import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/features/register/domain/entities/user_entity.dart';

abstract class RegisterRepo {
  Future<ApiResult<RegisterEntity>> register(
    String? username,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? rePassword,
    String? phone,
  );
}
