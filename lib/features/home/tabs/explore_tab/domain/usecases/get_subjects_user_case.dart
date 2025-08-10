import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/domain/entities/subjects_entity.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/domain/repos/get_subject_repo.dart';

@injectable
class GetSubjectsUserCase {
  final GetSubjectRepo getSubjectRepo;
  GetSubjectsUserCase(this.getSubjectRepo);
  Future<ApiResult<List<SubjectsEntity>>> call() async {
    ApiResult<List<SubjectsEntity>> subjectsResult =
        await getSubjectRepo.getSubjects();
    return subjectsResult;
  }
}
