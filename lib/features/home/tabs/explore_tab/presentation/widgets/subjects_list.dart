import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/presentation/cubit/explore_tab_cubit.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/presentation/widgets/subject_explore_card.dart';

class SubjetcsList extends StatelessWidget {
  const SubjetcsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ExploreTabCubit, ExploreTabState>(
        //  bloc: viewModel,
        builder: (context, state) {
          if (state is GetSubjectsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetSubjectsError) {
            return Center(
              child: Text(
                state.message ?? "",
                // style:
                //     TextStyles.font16BaseBlackRegular,
              ),
            );
          } else if (state is GetSubjectsLoaded) {
            return ListView.separated(
              itemBuilder: (context, index) {
                return SubjectHomeCard(
                  subject: state.subjects![index],
                );
              },
              separatorBuilder: (context, index) =>
                  SizedBox(height: 8.h),
              itemCount: state.subjects!.length,
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
