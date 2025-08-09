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

  setUp(() {
    mockUseCase = MockGetExamsUseCase();
    examsCubit = ExamsCubit(mockUseCase);
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
      expect: () => [ExamsLoading(), ExamsLoaded(mockExams)],
    );

    blocTest<ExamsCubit, ExamsState>(
      'emits [ExamsLoading, ExamsError] when useCase returns error',
      build: () {
        // when(() => mockUseCase.call())
        //     .thenAnswer((_) async => ApiErrorResult('Failed to load exams'));
        when(
          mockUseCase.call(),
        ).thenAnswer((_) async => ApiErrorResult('Failed to load exams'));
        return examsCubit;
      },
      act: (cubit) => cubit.getExamsById(),
      expect: () => [ExamsLoading(), ExamsError('Failed to load exams')],
    );
  });
}
