import 'package:injectable/injectable.dart';
import 'package:online_exam_app/features/exams/api/models/exams_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'exams_api.g.dart';

@injectable
@RestApi()
abstract class ExamsApi {
  @factoryMethod
  factory ExamsApi(Dio dio) = _ExamsApi;

  @GET('exams')
  Future<ExamsResponse> getExamsBySubject(
    @Query("subject") String subjectId,
  );
}
