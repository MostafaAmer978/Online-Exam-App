import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api_result/api_result.dart';
import 'package:online_exam_app/core/cache/shared_preferences.dart';
import 'package:online_exam_app/core/utiles/app_strings.dart';
import 'package:online_exam_app/features/login/api/client/login_api_client.dart';
import 'package:online_exam_app/features/login/api/models/response/user_response.dart';
import 'package:online_exam_app/features/login/data/datasources/login_remote_datasource.dart';
import 'package:online_exam_app/features/login/domain/entities/user_model.dart';
import 'package:dio/dio.dart';

@Injectable(as: LoginRemoteDataSource)
class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  LoginApiClient loginApiClient;

  LoginRemoteDataSourceImpl(this.loginApiClient);

  @override
  Future<ApiResult<UserModel>> login({String? email, String? password}) async {
    try {
      UserResponse userResponse = await loginApiClient.login({
        "email": email,
        "password": password,
      });
      UserModel? userModel = userResponse.user?.toUserModel();
      CacheHelper.saveData(AppStringsKey.tokenKey,userResponse.token);

      return ApiSuccessResult<UserModel>(
        data: userModel ?? UserModel(userId: "", username: ""),
      );
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 401) {
        return ApiErrorResult<UserModel>(
          errorMessage: e.message ?? "Invalid Data DioException",
        );
      } else {
        return ApiErrorResult<UserModel>(
          errorMessage:
              "Error Occurred DioException: ${e.response?.statusMessage} ${e.message}",
        );
      }
    } catch (e) {
      return ApiErrorResult<UserModel>(
        errorMessage: "Error Occurred : ${e.toString()}",
      );
    }
  }
}
