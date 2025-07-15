import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:online_exam_app/core/values/api_end_points.dart';

@module
abstract class DioModule {
  @singleton
  Dio get dio => Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));
}
