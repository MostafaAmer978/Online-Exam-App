import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api_result/api_result.dart';
import 'package:online_exam_app/features/login/api/client/login_api_client.dart';
import 'package:online_exam_app/features/login/data/datasources/login_local_datasource.dart';
import 'package:online_exam_app/features/login/domain/entities/user_model.dart';

@Injectable(as: LoginLocalDataSource)
class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  LoginApiClient loginApiClient;

  LoginLocalDataSourceImpl({required this.loginApiClient});

  @override
  Future<ApiResult<UserModel>> login({String? email, String? password}) async {
    throw UnimplementedError();
  }
}
