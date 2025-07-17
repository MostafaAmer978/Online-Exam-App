import 'package:injectable/injectable.dart';

import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/features/register/data/datasources/register_remate_data_source.dart';
import 'package:online_exam_app/features/register/domain/entities/user_entity.dart';
import 'package:online_exam_app/features/register/domain/repos/register_repo.dart';

@Injectable(as: RegisterRepo)
class RegisterRepoImpl implements RegisterRepo {
  RegisterRemoteDataSource registerRemoteDataSource;
  RegisterRepoImpl(this.registerRemoteDataSource);
  @override
  Future<ApiResult<RegisterEntity>> register(
    String? username,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? rePassword,
    String? phone,
  ) async {
    ApiResult<RegisterEntity> registerResult = await registerRemoteDataSource
        .register(
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
