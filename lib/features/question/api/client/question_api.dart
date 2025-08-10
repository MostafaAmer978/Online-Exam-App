import 'package:injectable/injectable.dart';
import 'package:online_exam_app/features/question/api/models/questions_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'question_api.g.dart';

@injectable
@RestApi()
abstract class QuestionApi {
  @factoryMethod
  factory QuestionApi(Dio dio) = _QuestionApi;

  @GET('questions')
  Future<QuestionsResponse> getQuestionById(
    @Query("exam") String examtId,
  );
}
