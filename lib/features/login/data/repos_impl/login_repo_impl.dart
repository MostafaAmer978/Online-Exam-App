import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/features/login/data/datasources/login_local_datasource.dart';
import 'package:online_exam_app/features/login/data/datasources/login_remote_datasource.dart';
import 'package:online_exam_app/features/login/domain/entities/user_model.dart';
import 'package:online_exam_app/features/login/domain/repos/login_repo.dart';

@Injectable(as: LoginRepoContract)
class LoginRepoImpl extends LoginRepoContract {
  LoginRemoteDataSource loginRemoteDataSource;
  LoginLocalDataSource loginLocalDataSource;

  LoginRepoImpl({
    required this.loginRemoteDataSource,
    required this.loginLocalDataSource,
  });

  @override
  Future<ApiResult<UserModel>> login({String? email, String? password}) async {
    ApiResult<UserModel> userModel = await loginRemoteDataSource.login(
      email: email,
      password: password,
    );
    return userModel;
  }
}
