import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/features/question/data/datasources/get_questions_data_source.dart';
import 'package:online_exam_app/features/question/data/repos_impl/get_questions_repo_impl.dart';
import 'package:online_exam_app/features/question/domain/entities/questions_entity.dart';

import 'get_questions_repo_impl_test.mocks.dart';

@GenerateMocks([GetQuestionsDataSource])
void main() {
  late MockGetQuestionsDataSource mockDataSource;
  late GetQuestionsRepoImpl repo;

  setUp(() {
    mockDataSource = MockGetQuestionsDataSource();
    repo = GetQuestionsRepoImpl(mockDataSource);
  });

  group('GetQuestionsRepoImpl', () {
    test('returns ApiSuccessResult when data source succeeds', () async {
      final mockEntity = QuestionsEntity(
        id: 'q1',
        question: 'What is Dart?',
        type: 'exam123',
      );

      final mockResult = ApiSuccessResult<List<QuestionsEntity>>([mockEntity]);

      when(
        mockDataSource.getQuestions(any),
      ).thenAnswer((_) async => mockResult);

      final result = await repo.getQuestions('exam123');

      expect(result, isA<ApiSuccessResult<List<QuestionsEntity>>>());
      expect(
        (result as ApiSuccessResult<List<QuestionsEntity>>).data.first.question,
        'What is Dart?',
      );
    });

    test('returns ApiErrorResult when data source fails', () async {
      final mockError = ApiErrorResult<List<QuestionsEntity>>('Server error');

      when(mockDataSource.getQuestions(any)).thenAnswer((_) async => mockError);

      final result = await repo.getQuestions('exam123');

      expect(result, isA<ApiErrorResult<List<QuestionsEntity>>>());
      expect(
        (result as ApiErrorResult<List<QuestionsEntity>>).errorMessage,
        'Server error',
      );
    });
  });
}
