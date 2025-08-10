import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/features/profile/api/models/response/profile_response.dart';
import 'package:online_exam_app/features/profile/domain/repos/Get_profile_repo_contract.dart';

@Injectable()
class GetProfileUseCase {
  GetProfileRepoContract getProfileRepoContract;

  GetProfileUseCase({required this.getProfileRepoContract});

  Future<ApiResult<ProfileResponse>> call() async {
    ApiResult<ProfileResponse> profileResponse = await getProfileRepoContract
        .getProfile();
    return profileResponse;
  }
}
