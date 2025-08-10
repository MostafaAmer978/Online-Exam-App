import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/features/login/domain/entities/user_model.dart';
import 'package:online_exam_app/features/login/domain/repos/login_repo.dart';

@injectable
class LoginUseCase {
  LoginRepoContract loginRepoContract;

  LoginUseCase({required this.loginRepoContract});

  Future<ApiResult<UserModel>> call({String? email, String? password}) async {
    ApiResult<UserModel> userModel = await loginRepoContract.login(
      email: email,
      password: password,
    );
    return userModel;
  }
}
