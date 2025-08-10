import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/features/exams/api/client/exams_api.dart';
import 'package:online_exam_app/features/exams/api/data_source_impl/get_exams_data_source_impl.dart';
import 'package:online_exam_app/features/exams/api/models/exams_dto.dart';
import 'package:online_exam_app/features/exams/api/models/exams_response.dart';
import 'package:online_exam_app/features/exams/domain/entities/exams_exntity.dart';
import 'package:dio/dio.dart';

import 'get_exams_data_source_impl_test.mocks.dart';

@GenerateMocks([ExamsApi])
void main() {
  late MockExamsApi mockExamsApi;
  late GetExamsDataSourceImpl dataSource;

  setUp(() {
    mockExamsApi = MockExamsApi();
    dataSource = GetExamsDataSourceImpl(mockExamsApi);
  });

  group('GetExamsDataSourceImpl', () {
    test('returns ApiSuccessResult when API call is successful', () async {
      // arrange
      final mockResponse = ExamsResponse(
        exams: [ExamsDTO(id: '1', title: 'Math Exam', subjectId: 'math101')],
      );

      when(
        mockExamsApi.getExamsBySubject(any),
      ).thenAnswer((_) async => mockResponse);

      // act
      final result = await dataSource.getExamsBySubject('math101');

      // assert
      expect(result, isA<ApiSuccessResult<List<ExamsEntity>>>());
      final exams = (result as ApiSuccessResult<List<ExamsEntity>>).data;
      expect(exams.length, 1);
      expect(exams.first.title, 'Math Exam');

      verify(mockExamsApi.getExamsBySubject('math101')).called(1);
    });

    test(
      'returns ApiErrorResult when DioException is thrown with message',
      () async {
        // arrange
        final mockErrorMessage = 'Failed to fetch exams';
        final dioException = DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            requestOptions: RequestOptions(path: ''),
            data: {'message': mockErrorMessage},
            statusCode: 400,
          ),
        );

        when(mockExamsApi.getExamsBySubject(any)).thenThrow(dioException);

        // act
        final result = await dataSource.getExamsBySubject('math101');

        // assert
        expect(result, isA<ApiErrorResult<List<ExamsEntity>>>());
        final error = result as ApiErrorResult<List<ExamsEntity>>;
        expect(error.errorMessage, mockErrorMessage);
      },
    );
  });
}
