
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/utiles/app_strings.dart';
import 'package:online_exam_app/features/login/presentation/cubit/login_cubit.dart';

class TextFormFields extends StatelessWidget {
  final LoginCubit loginCubit;
  const TextFormFields({super.key, required this.loginCubit});


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "This Email is not valid";
            }
            return null;
          },
          controller: loginCubit.emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            label: Text(AppStrings.email),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: AppStrings.enterYourEmail,
          ),
        ),
        SizedBox(height: 24.h),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "This Password is not valid";
            }
            return null;
          },
          controller: loginCubit.passwordController,
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            label: Text(AppStrings.password),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: AppStrings.enterYourPassword,
          ),
        ),
      ],
    );
  }
}
