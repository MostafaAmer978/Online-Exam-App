import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/api/client/subject_api.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/api/data_source_impl/get_subjects_remote_data_impl.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/api/models/subject_dto.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/api/models/subject_response.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/domain/entities/subjects_entity.dart';
import 'package:dio/dio.dart';

import 'get_subjects_remote_data_impl_test.mocks.dart';

@GenerateMocks([SubjectApi])
void main() {
  late GetSubjectsRemoteDataImpl remoteData;
  late MockSubjectApi mockApi;

  setUp(() {
    mockApi = MockSubjectApi();
    remoteData = GetSubjectsRemoteDataImpl(mockApi);
  });

  final response = SubjectResponse(
    subjects: [SubjectDTO(id: '1', name: 'Biology')],
  );

  test('returns success when API succeeds', () async {
    when(mockApi.getSubjects()).thenAnswer((_) async => response);

    final result = await remoteData.getSubjects();
    expect(result, isA<ApiSuccessResult<List<SubjectsEntity>>>());
    result as ApiSuccessResult<List<SubjectsEntity>>;
    expect(result.data.first.name, 'Biology');
  });

  test('returns error when DioException with message', () async {
    final dioError = DioException(
      requestOptions: RequestOptions(path: ''),
      response: Response(
        requestOptions: RequestOptions(path: ''),
        data: {'message': 'Unauthorized'},
        statusCode: 401,
      ),
      type: DioExceptionType.badResponse,
    );

    when(mockApi.getSubjects()).thenThrow(dioError);

    final result = await remoteData.getSubjects();
    expect(result, isA<ApiErrorResult<List<SubjectsEntity>>>());
    result as ApiErrorResult<List<SubjectsEntity>>;
    expect(result.errorMessage, 'Unauthorized');
  });

  test('returns error when unknown exception', () async {
    when(mockApi.getSubjects()).thenThrow(Exception('Unexpected'));

    final result = await remoteData.getSubjects();
    expect(result, isA<ApiErrorResult<List<SubjectsEntity>>>());
    result as ApiErrorResult<List<SubjectsEntity>>;
    expect(result.errorMessage, 'Exception: Unexpected');
  });
}
