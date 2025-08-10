import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/features/home/home_cubit/home_cubit.dart';

class ResultsTab extends StatelessWidget {
  const ResultsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is ResultTabState && state.resultData != null) {
          final resultData = state.resultData!;
          final correctAnswers = resultData['correct'];
          final totalQuestions = resultData['total'];
          final percentage = resultData['percentage'];

          return Scaffold(
            appBar: AppBar(title: const Text('Results'), centerTitle: true),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'You got $correctAnswers out of $totalQuestions questions correct!',
                  ),
                  Text('Your score: $percentage%'),
                ],
              ),
            ),
          );
        }
        return const Center(child: Text('No results to display yet.'));
      },
    );
  }
}
