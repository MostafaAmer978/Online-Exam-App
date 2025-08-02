// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:injectable/injectable.dart';
// import 'package:online_exam_app/core/api_rasult/api_result.dart';
// import 'package:online_exam_app/features/question/domain/entities/questions_entity.dart';
// import 'package:online_exam_app/features/question/domain/usecases/get_questions_use_case.dart';

// part 'question_state.dart';

// @injectable
// class QuestionCubit extends Cubit<QuestionState> {
//   GetQuestionsUseCase getQuestionsUseCase;
//   QuestionCubit(this.getQuestionsUseCase)
//     : super(QuestionsInitialState());

//   Future<void> getQuestions() async {
//     emit(QuestionsLoadingState());
//     final result = await getQuestionsUseCase.call();

//     switch (result) {
//       case ApiSuccessResult<List<QuestionsEntity>>():
//         emit(QuestionsSuccessState(result.data));
//         break;
//       case ApiErrorResult<List<QuestionsEntity>>():
//         emit(QuestionsErrorState(result.errorMessage));
//         break;
//     }
//   }
// }
