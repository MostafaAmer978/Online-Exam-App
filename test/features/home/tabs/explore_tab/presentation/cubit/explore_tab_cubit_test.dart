import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/domain/entities/subjects_entity.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/domain/usecases/get_subjects_user_case.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/presentation/cubit/explore_tab_cubit.dart';

import 'explore_tab_cubit_test.mocks.dart';

@GenerateMocks([GetSubjectsUserCase])
void main() {
  late ExploreTabCubit exploreTabCubit;
  late MockGetSubjectsUserCase mockGetSubjectsUserCase;

  setUp(() {
    mockGetSubjectsUserCase = MockGetSubjectsUserCase();
    exploreTabCubit = ExploreTabCubit(mockGetSubjectsUserCase);
  });

  final mockSubjects = [
    SubjectsEntity(id: '1', name: 'Math'),
    SubjectsEntity(id: '2', name: 'Science'),
  ];

  final successResult = ApiSuccessResult<List<SubjectsEntity>>(mockSubjects);
  final errorResult = ApiErrorResult<List<SubjectsEntity>>(
    'Failed to fetch subjects',
  );

  blocTest<ExploreTabCubit, ExploreTabState>(
    'emits [GetSubjectsLoading, GetSubjectsLoaded] when getSubjects succeeds',
    build: () {
      when(
        mockGetSubjectsUserCase.call(),
      ).thenAnswer((_) async => successResult);
      return exploreTabCubit;
    },
    act: (cubit) => cubit.getSubjects(),
    expect: () => [GetSubjectsLoading(), GetSubjectsLoaded(mockSubjects)],
  );

  blocTest<ExploreTabCubit, ExploreTabState>(
    'emits [GetSubjectsLoading, GetSubjectsError] when getSubjects fails',
    build: () {
      when(mockGetSubjectsUserCase.call()).thenAnswer((_) async => errorResult);
      return exploreTabCubit;
    },
    act: (cubit) => cubit.getSubjects(),
    expect: () => [
      GetSubjectsLoading(),
      GetSubjectsError('Failed to fetch subjects'),
    ],
  );
}
