import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/core/cache/lbar_prefs.dart';
import 'package:online_exam_app/features/question/domain/entities/questions_entity.dart';
import 'package:online_exam_app/features/question/domain/repos/get_questions_repo.dart';

@injectable
class GetQuestionsUseCase {
  GetQuestionsRepo getQuestionsRepo;
  GetQuestionsUseCase(this.getQuestionsRepo);
  Future<ApiResult<List<QuestionsEntity>>> call() async {
    ApiResult<List<QuestionsEntity>> questionsResult = await getQuestionsRepo
        .getQuestions(SharedPreferencesHelper.getString(key: 'examId'));
    return questionsResult;
  }
}
