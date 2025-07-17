import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:online_exam_app/core/values/api_end_points.dart';
import 'package:online_exam_app/features/register/api/model/register_response.dart';
import 'package:online_exam_app/features/register/data/model/register_request.dart';
import 'package:retrofit/retrofit.dart';

part 'register_api.g.dart';

@injectable
@RestApi()
abstract class RegisterApi {
  @factoryMethod
  factory RegisterApi(Dio dio) = _RegisterApi;

  @POST(AppEndpoints.register)
  Future<RegisterResponse> register({@Body() required RegisterRequest body});
}
