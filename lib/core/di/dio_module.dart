import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/utiles/constants.dart';

@module
abstract class DioModule {
  @singleton
  Dio get dio => Dio(BaseOptions(baseUrl: Constants.baseUrl),
  );
}
