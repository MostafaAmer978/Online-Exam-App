import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/data/datasources/get_subject_remote_data_source.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/domain/entities/subjects_entity.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/domain/repos/get_subject_repo.dart';

@Injectable(as: GetSubjectRepo)
class GetSubjectRepoImpl implements GetSubjectRepo {
  GetSubjectRemoteDataSource getSubjectRemoteDataSource;
  GetSubjectRepoImpl(this.getSubjectRemoteDataSource);
  @override
  Future<ApiResult<List<SubjectsEntity>>>
  getSubjects() async {
    ApiResult<List<SubjectsEntity>> subjectsResult =
        await getSubjectRemoteDataSource.getSubjects();
    return subjectsResult;
  }
}
