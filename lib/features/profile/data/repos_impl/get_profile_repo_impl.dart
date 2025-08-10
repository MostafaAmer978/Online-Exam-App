import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/features/profile/api/models/response/profile_response.dart';
import 'package:online_exam_app/features/profile/data/datasources/get_profile_local_datasource.dart';
import 'package:online_exam_app/features/profile/data/datasources/get_profile_remote_datasource.dart';
import 'package:online_exam_app/features/profile/domain/repos/Get_profile_repo_contract.dart';

@Injectable(as: GetProfileRepoContract)
class GetProfileRepoImpl extends GetProfileRepoContract {
  GetProfileRemoteDataSource getProfileRemoteDataSource;
  GetProfileLocalDataSource getProfileLocalDataSource;

  GetProfileRepoImpl({
    required this.getProfileRemoteDataSource,
    required this.getProfileLocalDataSource,
  });

  @override
  Future<ApiResult<ProfileResponse>> getProfile() async {
    ApiResult<ProfileResponse> profileResponse =
        await getProfileRemoteDataSource.getProfileUser();
    return profileResponse;
  }
}
