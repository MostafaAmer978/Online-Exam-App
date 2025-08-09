import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/data/datasources/get_subject_remote_data_source.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/data/repos_impl/get_subject_repo_impl.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/domain/entities/subjects_entity.dart';

import 'get_subject_repo_impl_test.mocks.dart';

@GenerateMocks([GetSubjectRemoteDataSource])
void main() {
  late GetSubjectRepoImpl repo;
  late MockGetSubjectRemoteDataSource mockRemote;

  setUp(() {
    mockRemote = MockGetSubjectRemoteDataSource();
    repo = GetSubjectRepoImpl(mockRemote);
  });

  final subjects = [SubjectsEntity(id: '1', name: 'Chemistry')];

  test('returns success from remote', () async {
    when(
      mockRemote.getSubjects(),
    ).thenAnswer((_) async => ApiSuccessResult(subjects));

    final result = await repo.getSubjects();
    expect(result, isA<ApiSuccessResult<List<SubjectsEntity>>>());
    result as ApiSuccessResult<List<SubjectsEntity>>;
    expect(result.data, subjects);
  });

  test('returns error from remote', () async {
    when(
      mockRemote.getSubjects(),
    ).thenAnswer((_) async => ApiErrorResult('Remote failed'));

    final result = await repo.getSubjects();
    expect(result, isA<ApiErrorResult<List<SubjectsEntity>>>());
    result as ApiErrorResult<List<SubjectsEntity>>;
    expect(result.errorMessage, 'Remote failed');
  });
}
