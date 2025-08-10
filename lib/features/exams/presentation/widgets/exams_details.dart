import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/config/routes/app_router.dart';
import 'package:online_exam_app/core/cache/lbar_prefs.dart';
import 'package:online_exam_app/core/reusable_component/custom_button.dart';
import 'package:online_exam_app/features/exams/domain/entities/exams_exntity.dart';

class ExamsDetails extends StatelessWidget {
  final ExamsEntity? entity;
  const ExamsDetails({this.entity, super.key});
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/ic_profit.png',
                  width: 42.w,
                  height: 47.h,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 8.w),
                Text(entity?.title ?? ""),
                SizedBox(width: mediaQuery * 0.3),
                Text('${entity?.duration ?? 0} Minutes'),
              ],
            ),
            Row(children: [Text('${entity?.numberOfQuestions} Question')]),
            Container(
              width: mediaQuery * 1,
              height: 1,
              color: Colors.grey,
              margin: const EdgeInsets.symmetric(vertical: 40),
            ),
            CustomButton(
              borderRadius: 16,
              size: Size(double.infinity, 48.h),
              backgroundColorButton: Theme.of(context).colorScheme.primary,
              onPressed: () {
                SharedPreferencesHelper.saveData(
                  key: 'examId',
                  value: entity?.id,
                );
                Navigator.pushNamed(context, AppRoutesName.questions);
              },
              // width: mediaQuery * 1,
              child: Text(
                'Start',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
