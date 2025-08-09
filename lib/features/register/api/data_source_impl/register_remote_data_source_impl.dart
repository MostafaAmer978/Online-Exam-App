import 'package:injectable/injectable.dart';

import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/features/register/api/client/register_api.dart';
import 'package:online_exam_app/features/register/api/model/register_response.dart';
import 'package:online_exam_app/features/register/data/datasources/register_remate_data_source.dart';
import 'package:online_exam_app/features/register/data/model/register_request.dart';
import 'package:online_exam_app/features/register/domain/entities/user_entity.dart';
import 'package:dio/dio.dart';

@Injectable(as: RegisterRemoteDataSource)
class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  RegisterApi registerApi;
  //  SecureStorageService secureStorageService;
  //this.secureStorageService
  RegisterRemoteDataSourceImpl(this.registerApi);
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
    try {
      RegisterResponse registerResponse = await registerApi.register(
        body: RegisterRequest(
          username: username,
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          rePassword: rePassword,
          phone: phone,
        ),
      );

      // if (registerResponse.token != null) {
      //   await secureStorageService.saveToken(registerResponse.token!);
      // }

      return ApiSuccessResult<RegisterEntity>(
        registerResponse.user!.toRegisterEntity(),
      );
    } catch (e) {
      if (e is DioException) {
        final responseData = e.response?.data;
        if (responseData != null && responseData is Map<String, dynamic>) {
          final message = responseData["message"] ?? "Unknown error";
          return ApiErrorResult<RegisterEntity>(message.toString());
        }
        return ApiErrorResult<RegisterEntity>(e.message ?? e.toString());
      }
      return ApiErrorResult<RegisterEntity>(e.toString());
    }
  }
}
