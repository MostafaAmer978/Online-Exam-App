import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/domain/entities/subjects_entity.dart';

import 'package:online_exam_app/features/home/tabs/explore_tab/domain/usecases/get_subjects_user_case.dart';

part 'explore_tab_state.dart';

@injectable
class ExploreTabCubit extends Cubit<ExploreTabState> {
  GetSubjectsUserCase getSubjectsUserCase;
  ExploreTabCubit(this.getSubjectsUserCase)
    : super(ExploreTabInitial());

  Future<void> getSubjects() async {
    emit(GetSubjectsLoading());
    final result = await getSubjectsUserCase.call();
    switch (result) {
      case ApiSuccessResult<List<SubjectsEntity>>():
        emit(GetSubjectsLoaded(result.data));
        log(result.data[0].toString());
      case ApiErrorResult<List<SubjectsEntity>>():
        emit(GetSubjectsError(result.errorMessage));
        log(result.errorMessage);
    }
  }
}
