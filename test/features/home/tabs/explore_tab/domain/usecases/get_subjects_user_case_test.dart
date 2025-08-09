import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/domain/entities/subjects_entity.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/domain/repos/get_subject_repo.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/domain/usecases/get_subjects_user_case.dart';

import 'get_subjects_user_case_test.mocks.dart';

@GenerateMocks([GetSubjectRepo])
void main() {
  late GetSubjectsUserCase useCase;
  late MockGetSubjectRepo mockRepo;

  setUp(() {
    mockRepo = MockGetSubjectRepo();
    useCase = GetSubjectsUserCase(mockRepo);
  });

  final subjects = [SubjectsEntity(id: '1', name: 'Physics')];

  test('returns success from repo', () async {
    when(
      mockRepo.getSubjects(),
    ).thenAnswer((_) async => ApiSuccessResult(subjects));

    final result = await useCase.call();
    expect(result, isA<ApiSuccessResult<List<SubjectsEntity>>>());
    result as ApiSuccessResult<List<SubjectsEntity>>;
    expect(result.data, subjects);
  });

  test('returns error from repo', () async {
    when(
      mockRepo.getSubjects(),
    ).thenAnswer((_) async => ApiErrorResult('Repo failed'));

    final result = await useCase.call();
    expect(result, isA<ApiErrorResult<List<SubjectsEntity>>>());
    result as ApiErrorResult<List<SubjectsEntity>>;
    expect(result.errorMessage, 'Repo failed');
  });
}
