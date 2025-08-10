import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/config/routes/app_router.dart';
import 'package:online_exam_app/features/question/presentation/cubit/questions_view_model/questions_cubit.dart';
import 'package:online_exam_app/features/question/presentation/views/widgets/no_queastion_widgets.dart';

class QuestionsView extends StatefulWidget {
  const QuestionsView({super.key});

  @override
  State<QuestionsView> createState() => _QuestionsViewState();
}

class _QuestionsViewState extends State<QuestionsView> {
  Timer? _timer;
  int _remainingTime = 25 * 60;
  bool _isResultShown = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        timer.cancel();
        _onTimerComplete();
      }
    });
  }

  Future<void> _onTimerComplete() async {
    await Future.delayed(Duration.zero);
    final viewModel = context.read<QuestionsCubit>();
    if (mounted) {
      _showTimeOutDialog(context, viewModel);
    }
  }

  void _showTimeOutDialog(BuildContext context, QuestionsCubit viewModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text(
            "Time Out!!",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          actions: [
            TextButton(
              child: const Text('View Score'),
              onPressed: () {
                setState(() {
                  _isResultShown = true;
                });
                final result = viewModel.calculateResult();
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  AppRoutesName.examsScore,
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

  String _formatTime(int second) {
    int minutes = second ~/ 60;
    int seconds = second % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
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
                return const NoQuestionsFound();
              }

              final currentQuestion =
                  viewModel.questionsList[viewModel.currentIndex];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40.h),

                  _buildHeader(context, viewModel),
                  const SizedBox(height: 28),
                  Text(
                    currentQuestion.question ?? '',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  _buildAnswerOptions(viewModel, _isResultShown),
                  const SizedBox(height: 80),

                  _buildNavigationButtons(context, viewModel, _isResultShown),
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

  Widget _buildHeader(BuildContext context, QuestionsCubit viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        SizedBox(width: 10.w),
        Row(
          children: [
            const Icon(Icons.alarm, size: 30),
            SizedBox(width: 10.w),

            Text(
              _formatTime(_remainingTime),
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
    );
  }

  Widget _buildAnswerOptions(QuestionsCubit viewModel, bool isResultShown) {
    final currentQuestion = viewModel.questionsList[viewModel.currentIndex];
    return Column(
      children: List.generate(currentQuestion.answers!.length, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isResultShown
                ? _getAnswerColor(viewModel, index)
                : const Color(0xffEDEFF3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: currentQuestion.type == 'single_choice'
              ? RadioListTile<int>(
                  value: index,
                  groupValue:
                      viewModel.singleChoiceAnswers[viewModel.currentIndex],
                  onChanged: isResultShown
                      ? null
                      : (value) {
                          setState(() {
                            viewModel.selectSingleChoiceAnswer(
                              viewModel.currentIndex,
                              index,
                            );
                          });
                        },
                  title: Text(currentQuestion.answers?[index].answer ?? ''),
                  activeColor: const Color(0xff02369C),
                )
              : CheckboxListTile(
                  value: viewModel
                      .multiChoiceAnswers[viewModel.currentIndex][index],
                  onChanged: isResultShown
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
                  title: Text(currentQuestion.answers?[index].answer ?? ''),
                  activeColor: const Color(0xff02369C),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
        );
      }),
    );
  }

  Color _getAnswerColor(QuestionsCubit viewModel, int answerIndex) {
    final currentQuestion = viewModel.questionsList[viewModel.currentIndex];
    final isCorrectAnswer =
        currentQuestion.answers?[answerIndex].key == currentQuestion.correct;
    final isUserSelected = currentQuestion.type == 'single_choice'
        ? viewModel.singleChoiceAnswers[viewModel.currentIndex] == answerIndex
        : viewModel.multiChoiceAnswers[viewModel.currentIndex][answerIndex];

    if (isUserSelected) {
      return isCorrectAnswer
          ? const Color(0xffcaf9cc)
          : const Color(0xfff8d2d2);
    }
    if (isCorrectAnswer) {
      return const Color(0xffcaf9cc);
    }
    return const Color(0xffEDEFF3);
  }

  Widget _buildNavigationButtons(
    BuildContext context,
    QuestionsCubit viewModel,
    bool isResultShown,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 2.3,
          child: ElevatedButton(
            onPressed: viewModel.previousQuestion,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 17),
              backgroundColor: Colors.white,
              side: const BorderSide(color: Colors.blue),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            child: const Text('Back', style: TextStyle(color: Colors.blue)),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2.3,
          child: ElevatedButton(
            onPressed: isResultShown
                ? null
                : () {
                    if (viewModel.currentIndex ==
                        viewModel.questionsList.length - 1) {
                      final resultData = viewModel.calculateResult();

                      Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutesName.home,
                        (route) => false,
                        arguments: resultData,
                      );

                      _timer?.cancel();
                      setState(() {
                        _isResultShown = true;
                      });
                      final result = viewModel.calculateResult();
                      Navigator.pushNamed(
                        context,
                        AppRoutesName.examsScore,
                        arguments: result,
                      );
                    } else {
                      viewModel.nextQuestion();
                    }
                  },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 17),
              backgroundColor:
                  viewModel.currentIndex == viewModel.questionsList.length - 1
                  ? Colors.green
                  : Colors.blue,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            child: Text(
              viewModel.currentIndex == viewModel.questionsList.length - 1
                  ? 'Result'
                  : 'Next',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
