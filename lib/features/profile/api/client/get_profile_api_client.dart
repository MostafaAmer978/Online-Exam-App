
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/values/api_end_points.dart';
import 'package:online_exam_app/features/profile/api/models/response/profile_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'get_profile_api_client.g.dart';

@Injectable()
@RestApi()
abstract  class GetProfileApiClient{
  @factoryMethod
  factory GetProfileApiClient(Dio dio) = _GetProfileApiClient;


  @GET(AppEndpoints.profile)
  Future<ProfileResponse> getProfileUser(
      @Header("token") String token,
      );
}