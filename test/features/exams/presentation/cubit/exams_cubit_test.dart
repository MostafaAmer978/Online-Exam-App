import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/features/exams/domain/entities/exams_exntity.dart';
import 'package:online_exam_app/features/exams/domain/usecases/get_exams_user_case.dart';
import 'package:online_exam_app/features/exams/presentation/cubit/exams_cubit.dart';

import 'exams_cubit_test.mocks.dart';

@GenerateMocks([GetExamsUseCase])
void main() {
  late MockGetExamsUseCase mockUseCase;
  late ExamsCubit examsCubit;

  setUpAll(() {
    mockUseCase = MockGetExamsUseCase();
    examsCubit = ExamsCubit(mockUseCase);

    provideDummy<ApiResult<List<ExamsEntity>>>(
      ApiSuccessResult<List<ExamsEntity>>([]),
    );
  });

  tearDown(() {
    examsCubit.close();
  });

  group('ExamsCubit', () {
    final mockExams = [
      ExamsEntity(id: '1', title: 'Math', subjectId: 'sub1'),
      ExamsEntity(id: '2', title: 'Physics', subjectId: 'sub2'),
    ];

    blocTest<ExamsCubit, ExamsState>(
      'emits [ExamsLoading, ExamsLoaded] when useCase returns success',
      build: () {
        when(
          mockUseCase.call(),
        ).thenAnswer((_) async => ApiSuccessResult(mockExams));
        return examsCubit;
      },
      act: (cubit) => cubit.getExamsById(),
      expect: () => [
        isA<ExamsLoading>(),
        predicate(
          (state) =>
              state is ExamsLoaded &&
              state.exams.length == mockExams.length &&
              state.exams.first.title == mockExams.first.title,
        ),
      ],
    );

    blocTest<ExamsCubit, ExamsState>(
      'emits [ExamsLoading, ExamsError] when useCase returns error',
      build: () {
        when(
          mockUseCase.call(),
        ).thenAnswer((_) async => ApiErrorResult('Failed to load exams'));
        return ExamsCubit(mockUseCase);
      },
      act: (cubit) => cubit.getExamsById(),
      expect: () => [
        isA<ExamsLoading>(),
        predicate(
          (state) =>
              state is ExamsError && state.errMessage == 'Failed to load exams',
        ),
      ],
    );
  });
}
