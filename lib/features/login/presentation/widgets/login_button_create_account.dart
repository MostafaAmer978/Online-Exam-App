import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/utiles/app_color.dart';
import 'package:online_exam_app/core/utiles/app_strings.dart';
import 'package:online_exam_app/features/login/presentation/cubit/login_cubit.dart';
import 'package:online_exam_app/features/login/presentation/cubit/login_state.dart';

class LoginButtonAndCreateAccount extends StatelessWidget {
  final LoginCubit loginCubit;

  const LoginButtonAndCreateAccount({super.key, required this.loginCubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            return SizedBox(
              width: double.infinity.w,
              height: 48.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(30.r),
                  ),
                ),
                onPressed: () {
                  loginCubit.login();
                },
                child: state.isLoadingState == true
                    ? CircularProgressIndicator(
                  color: AppColors.white,
                )
                    : Text(
                        AppStrings.login,
                        style: TextStyle(color: AppColors.white),
                      ),
              ),
            );
          },
        ),
        SizedBox(height: 16.h),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: AppStrings.doNotHaveAnAccount,
                style: TextStyle(color: AppColors.black),
              ),
              TextSpan(
                text: AppStrings.signUp,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    /// Navigator to signUp
                    // Navigator.pushNamed(context, AppRoutesName.signUpPage);
                  },
                style: TextStyle(
                  color: AppColors.black,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
