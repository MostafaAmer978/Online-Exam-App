import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/reusable_component/custom_button.dart';
import 'package:online_exam_app/core/utiles/build_appbar.dart';
import 'package:online_exam_app/features/question/presentation/cubit/questions_view_model/questions_cubit.dart';
import 'package:online_exam_app/features/question/presentation/views/exam_score_view.dart';

class QuestionsView extends StatefulWidget {
  const QuestionsView({super.key});
  static const String routeName = 'questionsView';
  @override
  State<QuestionsView> createState() => _QuestionsViewState();
}

class _QuestionsViewState extends State<QuestionsView> {
  Timer? _timer;
  // late QuestionsCubit viewModel;
  int _remainingTime = 25 * 60; // 30 minutes in seconds
  bool _isResultShown = false; // Flag to track if the result is shown

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        timer.cancel();
        onTimerComplete();
      }
    });
  }

  Future<void> onTimerComplete() {
    final viewModel = context.read<QuestionsCubit>();
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              Image.asset(
                'assets/images/hourglass.svg',
                height: 100,
                width: 100,
              ),

              const Text(
                "Time Out!!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          actions: [
            CustomButton(
              //     buttonColor: ColorManager.blue,
              child: Text('View Score '),
              onPressed: () {
                setState(() {
                  _isResultShown = true;
                });
                final result = viewModel.calculateResult();
                Navigator.pushNamed(
                  context,
                  ExamScoreView.routeName,
                  arguments: result,
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!mounted) {
      _timer?.cancel();
    }
  }

  @override
  void deactivate() {
    _timer?.cancel();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<QuestionsCubit>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
        child: BlocBuilder<QuestionsCubit, QuestionsState>(
          builder: (context, state) {
            if (state is QuestionsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is QuestionsFail) {
              return Center(child: Text(state.errorMessage.toString()));
            } else if (state is QuestionsSuccess || state is QuestionResult) {
              if (viewModel.questionsList.isEmpty) {
                return Scaffold(
                  body: Padding(
                    padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
                    child: Column(
                      children: [
                        buildAppBar(title: 'Exam', context: context),
                        Expanded(
                          child: Center(
                            child: Image.asset(
                              'assets/images/3d-isometric-robot-assistant-helping-developer-to-write-code.gif',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              final questionss = state is QuestionsSuccess
                  ? state.questions[viewModel.currentIndex]
                  : state is QuestionResult
                  ? viewModel.questionsList[viewModel.currentIndex]
                  : null;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios),
                      ),
                      SizedBox(width: 10.w),
                      Row(
                        children: [
                          Icon(Icons.alarm, size: 30),
                          SizedBox(width: 10.w),
                          Text(
                            formatTime(_remainingTime),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: _remainingTime <= (25 * 60) / 2
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Question ${viewModel.currentIndex + 1} of ${viewModel.questionsList.length}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  LinearProgressIndicator(
                    value:
                        (viewModel.currentIndex + 1) /
                        viewModel.questionsList.length,
                    backgroundColor: const Color(0xFFCFCFCF),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    questionss!.question ?? '',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    children: List.generate(questionss.answers!.length, (
                      index,
                    ) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: _isResultShown
                              ? questionss.type == 'single_choice'
                                    ? (viewModel.singleChoiceAnswers[viewModel
                                                  .currentIndex] ==
                                              index
                                          ? (questionss.answers![index].key ==
                                                    questionss.correct
                                                ? const Color(
                                                    0xffcaf9cc,
                                                  ) // Correct answer selected
                                                : const Color(
                                                    0xfff8d2d2,
                                                  )) // Incorrect answer selected
                                          : (viewModel.singleChoiceAnswers[viewModel
                                                            .currentIndex] !=
                                                        null &&
                                                    questionss
                                                            .answers?[index]
                                                            .key ==
                                                        questionss.correct
                                                ? const Color(
                                                    0xffcaf9cc,
                                                  ) // Show correct answer if an incorrect one was selected
                                                : const Color(
                                                    0xffEDEFF3,
                                                  ))) // Default background color
                                    : (viewModel.singleChoiceAnswers[viewModel
                                                  .currentIndex] ==
                                              null // Check if no answer was selected
                                          ? (questionss.answers?[index].key ==
                                                    questionss.correct
                                                ? const Color(
                                                    0xffcaf9cc,
                                                  ) // Show correct answer if no answer was selected
                                                : const Color(
                                                    0xffEDEFF3,
                                                  )) // Default background color
                                          : (questionss.answers?[index].key ==
                                                    questionss.correct
                                                ? const Color(
                                                    0xffcaf9cc,
                                                  ) // Show correct answer if an answer was selected
                                                : const Color(0xffEDEFF3)))
                              : const Color(0xffEDEFF3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: questionss.type == 'single_choice'
                            ? RadioListTile<int>(
                                value: index,
                                groupValue:
                                    viewModel.singleChoiceAnswers[viewModel
                                        .currentIndex],
                                onChanged: _isResultShown
                                    ? null
                                    : (value) {
                                        setState(() {
                                          viewModel.selectSingleChoiceAnswer(
                                            viewModel.currentIndex,
                                            value!,
                                          );
                                        });
                                      },
                                title: Text(
                                  questionss.answers?[index].answer ?? '',
                                ),
                                activeColor: const Color(0xff02369C),
                              )
                            : CheckboxListTile(
                                value:
                                    viewModel.multiChoiceAnswers[viewModel
                                        .currentIndex][index],
                                onChanged: _isResultShown
                                    ? null
                                    : (bool? value) {
                                        setState(() {
                                          viewModel.selectMultiChoiceAnswer(
                                            viewModel.currentIndex,
                                            index,
                                            value!,
                                          );
                                        });
                                      },
                                title: Text(
                                  questionss.answers?[index].answer ?? '',
                                ),
                                activeColor: const Color(0xff02369C),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              ),
                      );
                    }),
                  ),
                  const SizedBox(height: 80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.3,
                        child: ElevatedButton(
                          onPressed: () {
                            viewModel.previousQuestion();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 17),
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: Colors.blue),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Back',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.3,
                        child: ElevatedButton(
                          onPressed: () {
                            if (viewModel.currentIndex ==
                                viewModel.questionsList.length - 1) {
                              final result = viewModel.calculateResult();
                              setState(() {
                                _isResultShown = true;
                              });
                              Navigator.pushNamed(
                                context,
                                ExamScoreView.routeName,
                                arguments: result,
                              );
                            } else {
                              viewModel.nextQuestion();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 17),
                            backgroundColor:
                                viewModel.currentIndex ==
                                    viewModel.questionsList.length - 1
                                ? Colors.green
                                : Colors.blue,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          child: Text(
                            viewModel.currentIndex ==
                                    viewModel.questionsList.length - 1
                                ? 'Result'
                                : 'Next',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return const Center(child: Text('Something went wrong'));
            }
          },
        ),
      ),
    );
  }

  String formatTime(int second) {
    int minutes = second ~/ 60;
    int seconds = second % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
