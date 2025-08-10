import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/features/exams/domain/entities/exams_exntity.dart';

abstract class GetExamsRepo {
  Future<ApiResult<List<ExamsEntity>>> getExamsBySubject(
    String subjectId,
  );
}
