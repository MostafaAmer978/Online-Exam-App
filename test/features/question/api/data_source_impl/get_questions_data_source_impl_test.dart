import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/features/question/api/client/question_api.dart';
import 'package:online_exam_app/features/question/api/data_source_impl/get_questions_data_source_impl.dart';
import 'package:online_exam_app/features/question/api/models/question_dto.dart';
import 'package:online_exam_app/features/question/api/models/questions_response.dart';
import 'package:online_exam_app/features/question/domain/entities/questions_entity.dart';
import 'package:dio/dio.dart';

import 'get_questions_data_source_impl_test.mocks.dart';

@GenerateMocks([QuestionApi])
void main() {
  late MockQuestionApi mockQuestionApi;
  late GetQuestionsDataSourceImpl dataSource;

  setUp(() {
    mockQuestionApi = MockQuestionApi();
    dataSource = GetQuestionsDataSourceImpl(mockQuestionApi);
  });

  group('GetQuestionsDataSourceImpl', () {
    test('returns ApiSuccessResult when API call succeeds', () async {
      final mockResponse = QuestionsResponse(
        questions: [
          QuestionsDTO(id: 'q1', question: 'What is Flutter?', type: 'exam123'),
        ],
      );

      when(
        mockQuestionApi.getQuestionById(any),
      ).thenAnswer((_) async => mockResponse);

      final result = await dataSource.getQuestions('exam123');

      expect(result, isA<ApiSuccessResult<List<QuestionsEntity>>>());
      final questions =
          (result as ApiSuccessResult<List<QuestionsEntity>>).data;
      expect(questions.first.question, 'What is Flutter?');
    });

    test('returns ApiErrorResult when DioException is thrown', () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          requestOptions: RequestOptions(path: ''),
          data: {'message': 'Failed to load questions'},
          statusCode: 400,
        ),
      );

      when(mockQuestionApi.getQuestionById(any)).thenThrow(dioException);

      final result = await dataSource.getQuestions('exam123');

      expect(result, isA<ApiErrorResult<List<QuestionsEntity>>>());
      expect(
        (result as ApiErrorResult<List<QuestionsEntity>>).errorMessage,
        'Failed to load questions',
      );
    });
  });
}
