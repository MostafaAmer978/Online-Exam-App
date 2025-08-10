import 'package:flutter/material.dart';
import 'package:online_exam_app/core/utiles/build_appbar.dart';

class NoQuestionsFound extends StatelessWidget {
  const NoQuestionsFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
