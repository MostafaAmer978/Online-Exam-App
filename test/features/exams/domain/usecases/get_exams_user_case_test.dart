import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/features/exams/domain/entities/exams_exntity.dart';
import 'package:online_exam_app/features/exams/domain/repos/get_exams_repo.dart';
import 'package:online_exam_app/features/exams/domain/usecases/get_exams_user_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'get_exams_user_case_test.mocks.dart';

@GenerateMocks([GetExamsRepo])
void main() {
  late MockGetExamsRepo mockRepo;
  late GetExamsUseCase useCase;

  setUp(() {
    mockRepo = MockGetExamsRepo();
    useCase = GetExamsUseCase(mockRepo);
  });

  group('GetExamsUseCase', () {
    test('returns ApiSuccessResult when repo returns success', () async {
      // arrange
      const subjectId = 'chem101';
      SharedPreferences.setMockInitialValues({'subject': subjectId});

      final mockEntity = ExamsEntity(
        id: '1',
        title: 'Chemistry Exam',
        subjectId: subjectId,
      );

      final mockResult = ApiSuccessResult<List<ExamsEntity>>([mockEntity]);

      when(
        mockRepo.getExamsBySubject(subjectId),
      ).thenAnswer((_) async => mockResult);

      // act
      final result = await useCase();

      // assert
      expect(result, isA<ApiSuccessResult<List<ExamsEntity>>>());
      final exams = (result as ApiSuccessResult<List<ExamsEntity>>).data;
      expect(exams.first.title, 'Chemistry Exam');

      verify(mockRepo.getExamsBySubject(subjectId)).called(1);
    });

    test('returns ApiErrorResult when repo returns error', () async {
      // arrange
      const subjectId = 'chem101';
      SharedPreferences.setMockInitialValues({'subject': subjectId});

      final mockError = ApiErrorResult<List<ExamsEntity>>('Server error');

      when(
        mockRepo.getExamsBySubject(subjectId),
      ).thenAnswer((_) async => mockError);

      // act
      final result = await useCase();

      // assert
      expect(result, isA<ApiErrorResult<List<ExamsEntity>>>());
      final error = result as ApiErrorResult<List<ExamsEntity>>;
      expect(error.errorMessage, 'Server error');

      verify(mockRepo.getExamsBySubject(subjectId)).called(1);
    });
  });
}
