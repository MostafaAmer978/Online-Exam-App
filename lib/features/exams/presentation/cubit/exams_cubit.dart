import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/features/exams/domain/entities/exams_exntity.dart';
import 'package:online_exam_app/features/exams/domain/usecases/get_exams_user_case.dart';

part 'exams_state.dart';

@injectable
class ExamsCubit extends Cubit<ExamsState> {
  GetExamsUseCase getExamsUseCase;
  ExamsCubit(this.getExamsUseCase)
    : super(ExamsInitial());

  Future<void> getExamsById() async {
    emit(ExamsLoading());
    final result = await getExamsUseCase.call();
    switch (result) {
      case ApiSuccessResult<List<ExamsEntity>>():
        emit(ExamsLoaded(result.data));
      // log(result.data[0].toString());
      // print(result.data[0].toString());
      case ApiErrorResult<List<ExamsEntity>>():
        emit(ExamsError(result.errorMessage));
      // log(result.errorMessage);
      // print(result.errorMessage);
    }
  }
}
