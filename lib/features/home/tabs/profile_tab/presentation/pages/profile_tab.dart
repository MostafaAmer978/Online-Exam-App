import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/config/app_cubit/app_cubit.dart';
import 'package:online_exam_app/config/routes/app_router.dart';
import 'package:online_exam_app/core/reusable_component/custom_button.dart';
import 'package:online_exam_app/core/utiles/app_color.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit, AppState>(
      listener: (context, state) {
        if (!state.isAuthenticated) {
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(AppRoutesName.register, (route) => false);
        }
      },
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                size: Size(double.infinity, 48.h),
                backgroundColorButton: AppColors.blue,
                onPressed: () {
                  context.read<AppCubit>().logout();
                },
                child: Text('Logout', style: TextStyle(color: AppColors.white)),
              ),
            ),
          );
        },
      ),
    );
  }
}
