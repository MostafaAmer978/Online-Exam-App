import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/features/question/domain/entities/questions_entity.dart';

abstract class GetQuestionsDataSource {
  Future<ApiResult<List<QuestionsEntity>>> getQuestions(
    String examId,
  );
}
