import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/config/routes/app_router.dart';
import 'package:online_exam_app/features/exams/domain/entities/exams_exntity.dart';
import 'package:online_exam_app/features/exams/presentation/cubit/exams_cubit.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/domain/entities/subjects_entity.dart';

class ExamsPage extends StatelessWidget {
  final SubjectsEntity? subject;

  const ExamsPage({super.key, this.subject});

  @override
  Widget build(BuildContext context) {
    //  ExamsCubit examsCubit = getIt<ExamsCubit>();
    return Scaffold(
      appBar: AppBar(title: Text(subject?.name ?? '')),
      body: BlocBuilder<ExamsCubit, ExamsState>(
        builder: (context, state) {
          if (state is ExamsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ExamsError) {
            return Center(child: Text(state.errMessage));
          } else if (state is ExamsLoaded) {
            if (state.exams.isEmpty) {
              return Center(child: Text('No Exams'));
            }
            return ListView.separated(
              itemBuilder: (context, index) {
                return ExamsCardWidget(state.exams[index]);
              },
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemCount: state.exams.length,
            );
          } else {
            return const Center(child: Text('something rong'));
          }
        },
      ),
    );
  }
}

class ExamsCardWidget extends StatelessWidget {
  final ExamsEntity exam;
  const ExamsCardWidget(this.exam, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutesName.examsDetails,
          arguments: exam,
        );
      },
      child: SizedBox(
        height: 103.h,
        child: Card(
          color: Color(0xffffffff),
          child: Row(
            children: [
              SizedBox(width: 24.w),
              Image.asset(
                'assets/images/ic_science.png',
                height: 71.h,
                width: 60.w,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
              SizedBox(width: 8.w),
              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Column(
                          children: [
                            Text(
                              exam.title ?? "",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              '${exam.numberOfQuestions ?? ""} Question',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        Text(
                          '${exam.duration ?? ""} Minutes',
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(color: Color(0xff143473)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
