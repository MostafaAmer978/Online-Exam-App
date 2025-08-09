import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/config/routes/app_router.dart';
import 'package:online_exam_app/core/cache/lbar_prefs.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/domain/entities/subjects_entity.dart';

class SubjectHomeCard extends StatelessWidget {
  final SubjectsEntity subject;
  const SubjectHomeCard({required this.subject, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        SharedPreferencesHelper.saveData(key: 'subject', value: subject.id);
        Navigator.pushNamed(context, AppRoutesName.exams, arguments: subject);
      },
      child: SizedBox(
        height: 100.h,
        child: Card(
          color: Color(0xffffffff),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  height: 60.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    image: DecorationImage(
                      image: NetworkImage(subject.icon ?? ''),
                    ),
                  ),
                ),

                SizedBox(width: 14.5.w),
                Text(
                  subject.name ?? '',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
