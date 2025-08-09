import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/features/question/domain/entities/questions_entity.dart';
import 'package:online_exam_app/features/question/domain/repos/get_questions_repo.dart';
import 'package:online_exam_app/features/question/domain/usecases/get_questions_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'get_questions_use_case_test.mocks.dart';

@GenerateMocks([GetQuestionsRepo])
void main() {
  late MockGetQuestionsRepo mockRepo;
  late GetQuestionsUseCase useCase;

  setUp(() {
    mockRepo = MockGetQuestionsRepo();
    useCase = GetQuestionsUseCase(mockRepo);
  });

  group('GetQuestionsUseCase', () {
    test('returns ApiSuccessResult when repo succeeds', () async {
      const examId = 'exam123';
      SharedPreferences.setMockInitialValues({'examId': examId});

      final mockEntity = QuestionsEntity(
        id: 'q1',
        question: 'Explain BLoC pattern',
        type: examId,
      );

      final mockResult = ApiSuccessResult<List<QuestionsEntity>>([mockEntity]);

      when(mockRepo.getQuestions(examId)).thenAnswer((_) async => mockResult);

      final result = await useCase();

      expect(result, isA<ApiSuccessResult<List<QuestionsEntity>>>());
      expect(
        (result as ApiSuccessResult<List<QuestionsEntity>>).data.first.question,
        'Explain BLoC pattern',
      );
    });

    test('returns ApiErrorResult when repo fails', () async {
      const examId = 'exam123';
      SharedPreferences.setMockInitialValues({'examId': examId});

      final mockError = ApiErrorResult<List<QuestionsEntity>>(
        'No questions found',
      );

      when(mockRepo.getQuestions(examId)).thenAnswer((_) async => mockError);

      final result = await useCase();

      expect(result, isA<ApiErrorResult<List<QuestionsEntity>>>());
      expect(
        (result as ApiErrorResult<List<QuestionsEntity>>).errorMessage,
        'No questions found',
      );
    });
  });
}
