import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/features/question/data/datasources/get_questions_data_source.dart';
import 'package:online_exam_app/features/question/domain/entities/questions_entity.dart';
import 'package:online_exam_app/features/question/domain/repos/get_questions_repo.dart';

@Injectable(as: GetQuestionsRepo)
class GetQuestionsRepoImpl implements GetQuestionsRepo {
  GetQuestionsDataSource getQuestionsDataSource;

  GetQuestionsRepoImpl(this.getQuestionsDataSource);
  @override
  Future<ApiResult<List<QuestionsEntity>>> getQuestions(
    String examId,
  ) async {
    ApiResult<List<QuestionsEntity>> questionsResult =
        await getQuestionsDataSource.getQuestions(examId);
    return questionsResult;
  }
}
