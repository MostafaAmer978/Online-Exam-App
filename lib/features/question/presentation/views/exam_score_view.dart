import 'package:flutter/material.dart';
import 'package:online_exam_app/core/reusable_component/custom_button.dart';
import 'package:online_exam_app/core/utiles/build_appbar.dart';
import 'package:online_exam_app/features/home/views/home_page.dart';
import 'package:online_exam_app/features/question/presentation/views/questions_view.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ExamScoreView extends StatelessWidget {
  final Map<String, dynamic> results;
  const ExamScoreView({super.key, required this.results});
  static const String routeName = 'exam_score';
  @override
  Widget build(BuildContext context) {
    // final Map<String, dynamic> results =
    //     ModalRoute.of(context)!.settings.arguments
    //         as Map<String, dynamic>;
    final int correctAnswers = results['correct'];
    final int incorrectAnswers = results['wrong'];
    final int totalAnswers = correctAnswers + incorrectAnswers;
    final double percentage = (totalAnswers > 0)
        ? (correctAnswers / totalAnswers) * 100
        : 0;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildAppBar(
              title: 'Exam Score',
              onTap: true,
              routeName: HomePage.routeName,
              context: context,
            ),
            const SizedBox(height: 40),
            const Text(
              "Your score",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircularPercentIndicator(
                  radius: 70.0,
                  animation: true,
                  animationDuration: 1000,
                  lineWidth: 10.0,
                  percent: percentage / 100,
                  center: Text(
                    '${percentage.toStringAsFixed(0)}%',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  progressColor: Colors.blue,
                  backgroundColor: Colors.red,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Correct',
                            style: TextStyle(color: Colors.blue, fontSize: 18),
                          ),
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.blue.withOpacity(0.1),
                            child: Text(
                              correctAnswers.toString(),
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Incorrect',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 14,
                                  backgroundColor: Colors.red.withOpacity(0.1),
                                  child: Text(
                                    incorrectAnswers.toString(),
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80),
            CustomButton(
              size: const Size(double.infinity, 47),
              borderRadius: 33,
              backgroundColorButton: Colors.blue,
              child: Text(
                'Show Result',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: Colors.white),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 24),
            CustomButton(
              size: const Size(double.infinity, 47),
              borderRadius: 33,
              backgroundColorButton: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, QuestionsView.routeName);
              },
              // side: const BorderSide(
              //   color: ColorManager.blue,
              // ),
              // textColor: ColorManager.blue,
              child: Text('Start Again'),
            ),
          ],
        ),
      ),
    );
  }
}
