import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/domain/entities/subjects_entity.dart';

abstract class GetSubjectRepo {
  Future<ApiResult<List<SubjectsEntity>>> getSubjects();
}
