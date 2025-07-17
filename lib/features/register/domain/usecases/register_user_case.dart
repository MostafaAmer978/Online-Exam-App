import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/features/register/domain/entities/user_entity.dart';
import 'package:online_exam_app/features/register/domain/repos/register_repo.dart';

@injectable
class RegisterUserCase {
  RegisterRepo registerRepo;
  RegisterUserCase(this.registerRepo);

  Future<ApiResult<RegisterEntity>> call(
    String? username,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? rePassword,
    String? phone,
  ) async {
    ApiResult<RegisterEntity> registerResult = await registerRepo.register(
      username,
      firstName,
      lastName,
      email,
      password,
      rePassword,
      phone,
    );
    return registerResult;
  }
}
