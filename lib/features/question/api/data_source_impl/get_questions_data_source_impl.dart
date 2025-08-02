import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/features/question/api/client/question_api.dart';
import 'package:online_exam_app/features/question/api/models/questions_response.dart';
import 'package:online_exam_app/features/question/data/datasources/get_questions_data_source.dart';
import 'package:online_exam_app/features/question/domain/entities/questions_entity.dart';
import 'package:dio/dio.dart';

@Injectable(as: GetQuestionsDataSource)
class GetQuestionsDataSourceImpl
    implements GetQuestionsDataSource {
  QuestionApi questionApi;
  GetQuestionsDataSourceImpl(this.questionApi);
  @override
  Future<ApiResult<List<QuestionsEntity>>> getQuestions(
    String examId,
  ) async {
    try {
      QuestionsResponse questionsResponse =
          await questionApi.getQuestionById(examId);
      return ApiSuccessResult<List<QuestionsEntity>>(
        questionsResponse.questions!
            .map((e) => e.toQuestionsEntity())
            .toList(),
      );
    } catch (e) {
      if (e is DioException) {
        final responseData = e.response?.data;
        if (responseData != null &&
            responseData is Map<String, dynamic>) {
          final message =
              responseData["message"] ?? "Unknown error";
          return ApiErrorResult<List<QuestionsEntity>>(
            message.toString(),
          );
        }
        return ApiErrorResult<List<QuestionsEntity>>(
          e.message ?? e.toString(),
        );
      }
      return ApiErrorResult<List<QuestionsEntity>>(
        e.toString(),
      );
    }
  }
}
