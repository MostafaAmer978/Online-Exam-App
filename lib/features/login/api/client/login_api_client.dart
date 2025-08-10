import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/values/api_end_points.dart';
import 'package:online_exam_app/features/login/api/models/response/user_response.dart';
import 'package:retrofit/retrofit.dart';

part 'login_api_client.g.dart';

@injectable
@RestApi()
abstract class LoginApiClient {
  @factoryMethod
  factory LoginApiClient(Dio dio) = _LoginApiClient;

  @POST(AppEndpoints.login)
  Future<UserResponse> login(@Body() Map<String, dynamic> body);
}
