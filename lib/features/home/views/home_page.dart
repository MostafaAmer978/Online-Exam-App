import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/di/di.dart';
import 'package:online_exam_app/core/values/app_strings.dart';
import 'package:online_exam_app/features/home/home_cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final HomeCubit cubit = getIt.get<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: cubit,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: _buildAppBarTitle(cubit.currentIndex),
          ),
          body: IndexedStack(index: cubit.currentIndex, children: cubit.tabs),
          bottomNavigationBar: _bottomNavigationBarWidget(),
        );
      },
    );
  }

  Widget _buildAppBarTitle(int index) {
    return index == 0
        ? Text(
            AppStrings.surveyText,
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
          )
        : index == 1
        ? Text(
            AppStrings.resultText,
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
          )
        : Text(
            AppStrings.profileText,
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
          );
  }

  Widget _bottomNavigationBarWidget() {
    return BottomNavigationBar(
      backgroundColor: Color(0xffedeff3),
      currentIndex: cubit.currentIndex,
      // selectedItemColor: Color(0xffccd7eb),
      unselectedItemColor: Colors.black,
      selectedLabelStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
      ),
      onTap: (index) {
        cubit.onTabClicked(index);
      },
      items: [
        BottomNavigationBarItem(
          icon: _buildIconWithBackground(
            icon: Icon(Icons.explore),
            isSelected: cubit.currentIndex == 0,
          ),
          label: AppStrings.exploreText,

          backgroundColor: Color(0xffccd7eb),
        ),
        BottomNavigationBarItem(
          icon: _buildIconWithBackground(
            icon: Icon(Icons.restore_outlined),

            isSelected: cubit.currentIndex == 1,
          ),
          label: AppStrings.resultText,
        ),
        BottomNavigationBarItem(
          icon: _buildIconWithBackground(
            icon: Icon(Icons.person),

            isSelected: cubit.currentIndex == 2,
          ),
          label: AppStrings.profileText,
        ),
      ],
    );
  }

  Widget _buildIconWithBackground({
    required Widget icon,
    required bool isSelected,
  }) {
    return Container(
      height: 32.h,
      width: 64.w,
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.transparent,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: icon,
    );
  }
}
