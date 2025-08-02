import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/core/cache/shared_preferences.dart';
import 'package:online_exam_app/features/exams/domain/entities/exams_exntity.dart';
import 'package:online_exam_app/features/exams/domain/repos/get_exams_repo.dart';

@injectable
class GetExamsUseCase {
  final GetExamsRepo getExamsRepo;
  GetExamsUseCase(this.getExamsRepo);
  Future<ApiResult<List<ExamsEntity>>> call() async {
    ApiResult<List<ExamsEntity>> examsResult =
        await getExamsRepo.getExamsBySubject(
          SharedPreferencesHelper.getString(
            key: 'subject',
          ),
        );
    return examsResult;
  }
}
