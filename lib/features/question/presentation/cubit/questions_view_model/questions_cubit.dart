import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:flutter/material.dart';
import 'package:online_exam_app/features/question/domain/entities/questions_entity.dart';
import 'package:online_exam_app/features/question/domain/usecases/get_questions_use_case.dart';

part 'questions_state.dart';

@injectable
class QuestionsCubit extends Cubit<QuestionsState> {
  GetQuestionsUseCase getQuestionsUseCase;
  List<QuestionsEntity> questionsList = [];
  int currentIndex = 0;
  List<int?> singleChoiceAnswers = [];
  List<List<bool>> multiChoiceAnswers = [];
  List<Color> answerColors = [];

  QuestionsCubit(this.getQuestionsUseCase) : super(QuestionsInitial());

  Future<void> getQuestionById() async {
    emit(QuestionsLoading());
    final result = await getQuestionsUseCase.call();
    if (result is ApiSuccessResult<List<QuestionsEntity>>) {
      questionsList = result.data;
      singleChoiceAnswers = List.filled(questionsList.length, null);
      multiChoiceAnswers = List.generate(
        questionsList.length,
        (_) => List.filled(4, false),
      );
      answerColors = List.generate(questionsList.length, (_) => Colors.grey);
      emit(QuestionsSuccess(questionsList));
    } else if (result is ApiErrorResult<List<QuestionsEntity>>) {
      emit(QuestionsFail(result.errorMessage));
    }
  }

  void selectSingleChoiceAnswer(int questionIndex, int answerIndex) {
    singleChoiceAnswers[questionIndex] = answerIndex;
    emit(QuestionsSuccess(questionsList));
  }

  void selectMultiChoiceAnswer(
    int questionIndex,
    int answerIndex,
    bool isSelected,
  ) {
    multiChoiceAnswers[questionIndex][answerIndex] = isSelected;
    emit(QuestionsSuccess(questionsList));
  }

  void nextQuestion() {
    if (currentIndex < questionsList.length - 1) {
      currentIndex++;
      emit(QuestionsSuccess(questionsList));
    }
  }

  void previousQuestion() {
    if (currentIndex > 0) {
      currentIndex--;
      emit(QuestionsSuccess(questionsList));
    }
  }

  Map<String, dynamic> calculateResult() {
    int correctAnswer = 0;
    int totalQuestions = questionsList.length;

    for (int i = 0; i < totalQuestions; i++) {
      if (singleChoiceAnswers[i] != null &&
          questionsList[i].answers![singleChoiceAnswers[i]!].key ==
              questionsList[i].correct) {
        correctAnswer++;
      }
      log('Correct Answer: $correctAnswer');
    }
    return {
      'correct': correctAnswer,
      'wrong': totalQuestions - correctAnswer,
      'total': totalQuestions,
      'percentage': ((correctAnswer / totalQuestions) * 100).toStringAsFixed(2),
    };
  }
}
