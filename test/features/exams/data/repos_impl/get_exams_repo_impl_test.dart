import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/features/exams/data/datasources/get_exams_remote_data_source.dart';
import 'package:online_exam_app/features/exams/data/repos_impl/get_exams_repo_impl.dart';
import 'package:online_exam_app/features/exams/domain/entities/exams_exntity.dart';
import 'package:test/test.dart';

import 'get_exams_repo_impl_test.mocks.dart';

@GenerateMocks([GetExamsRemoteDataSource])
void main() {
  late MockGetExamsRemoteDataSource mockRemoteDataSource;
  late GetExamsRepoImpl repo;
  late List<ExamsEntity> mockEntityList;

  setUpAll(() {
    mockRemoteDataSource = MockGetExamsRemoteDataSource();
    repo = GetExamsRepoImpl(mockRemoteDataSource);
    provideDummy<ApiResult<List<ExamsEntity>>>(
      ApiSuccessResult<List<ExamsEntity>>([]),
    );
    mockEntityList = [
      ExamsEntity(id: '1', title: 'Physics Exam', subjectId: 'phy101'),
      ExamsEntity(id: '2', title: 'Physics Exam 2', subjectId: 'phy102'),
    ];
  });

  group('GetExamsRepoImpl', () {
    test('returns ApiSuccessResult when remote data source succeeds', () async {
      // arrange

      final mockResult = ApiSuccessResult<List<ExamsEntity>>(mockEntityList);

      when(
        mockRemoteDataSource.getExamsBySubject(any),
      ).thenAnswer((_) async => mockResult);

      // act
      final result = await repo.getExamsBySubject('phy101');

      // assert
      expect(result, isA<ApiSuccessResult<List<ExamsEntity>>>());
      final exams = (result as ApiSuccessResult<List<ExamsEntity>>).data;
      expect(exams.length, 2);
      expect(exams.first.title, 'Physics Exam');

      verify(mockRemoteDataSource.getExamsBySubject('phy101')).called(1);
    });

    test('returns ApiErrorResult when remote data source fails', () async {
      // arrange
      final mockError = ApiErrorResult<List<ExamsEntity>>('Network error');

      when(
        mockRemoteDataSource.getExamsBySubject(any),
      ).thenAnswer((_) async => mockError);

      // act
      final result = await repo.getExamsBySubject('phy101');

      // assert
      expect(result, isA<ApiErrorResult<List<ExamsEntity>>>());
      final error = result as ApiErrorResult<List<ExamsEntity>>;
      expect(error.errorMessage, 'Network error');

      verify(mockRemoteDataSource.getExamsBySubject('phy101')).called(1);
    });
  });
}
