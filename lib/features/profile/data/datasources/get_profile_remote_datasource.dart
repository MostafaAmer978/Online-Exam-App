import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/features/profile/api/models/response/profile_response.dart';

abstract class GetProfileRemoteDataSource{
  Future<ApiResult<ProfileResponse>> getProfileUser();
}