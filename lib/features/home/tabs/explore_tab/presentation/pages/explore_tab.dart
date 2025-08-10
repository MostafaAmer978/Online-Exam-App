import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/di/di.dart';
import 'package:online_exam_app/core/reusable_component/custom_textfield.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/presentation/cubit/explore_tab_cubit.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/presentation/widgets/subjects_list.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({super.key});

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<ExploreTabCubit>()..getSubjects(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
              borderRadius: 20,
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              contentPadding: const EdgeInsets.all(16),
              fillColor: Colors.transparent,
              hintText: 'Search',
            ),
            SizedBox(height: 20.h),
            Text(
              'Browse by subject',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10.h),

            SubjetcsList(),
          ],
        ),
      ),
    );
  }
}
