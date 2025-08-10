import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/features/exams/data/datasources/get_exams_remote_data_source.dart';
import 'package:online_exam_app/features/exams/domain/entities/exams_exntity.dart';
import 'package:online_exam_app/features/exams/domain/repos/get_exams_repo.dart';

@Injectable(as: GetExamsRepo)
class GetExamsRepoImpl implements GetExamsRepo {
  GetExamsRemoteDataSource getExamsRemoteDataSource;

  GetExamsRepoImpl(this.getExamsRemoteDataSource);
  @override
  Future<ApiResult<List<ExamsEntity>>> getExamsBySubject(
    String subjectId,
  ) async {
    ApiResult<List<ExamsEntity>> examsResult =
        await getExamsRemoteDataSource.getExamsBySubject(
          subjectId,
        );
    return examsResult;
  }
}
