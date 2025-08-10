import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:online_exam_app/core/cache/storage_source.dart';
import 'package:online_exam_app/core/values/api_end_points.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio dio(SecureStorageService secureStorageService) {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppEndpoints.baseUrl,
        headers: {
          'Content-Type': 'application/json',
          "Accept": "application/json",
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await secureStorageService.readToken();
          if (token != null && token.isNotEmpty) {
            options.headers['token'] = token;
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          return handler.next(e);
        },
      ),
    );

    return dio;
  }
}
