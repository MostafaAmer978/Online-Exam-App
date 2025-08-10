import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/core/utiles/app_strings.dart';
import 'package:online_exam_app/features/profile/api/client/get_profile_api_client.dart';
import 'package:online_exam_app/features/profile/api/models/response/profile_response.dart';
import 'package:online_exam_app/features/profile/data/datasources/get_profile_remote_datasource.dart';
import 'package:dio/dio.dart';

@Injectable(as: GetProfileRemoteDataSource)
class GetProfileRemoteDataSourceImpl extends GetProfileRemoteDataSource {
  GetProfileApiClient getProfileApiClient;

  GetProfileRemoteDataSourceImpl({required this.getProfileApiClient});

  @override
  Future<ApiResult<ProfileResponse>> getProfileUser() async {
    try {
      ProfileResponse profileResponse = await getProfileApiClient
          .getProfileUser(AppStringsKey.tokenKey);
      return ApiSuccessResult<ProfileResponse>(profileResponse);
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 401) {
        return ApiErrorResult<ProfileResponse>(
            e.message ?? "Invalid Data DioException");
      } else {
        return ApiErrorResult<ProfileResponse>(
            "Error Occurred DioException: ${e.response?.statusCode} ${e.response
                ?.statusMessage} ${e.message}");
      }
    }

    catch (e) {
      return ApiErrorResult<ProfileResponse>(
          "Error Occurred : ${e.toString()}");
    }
  }
}
