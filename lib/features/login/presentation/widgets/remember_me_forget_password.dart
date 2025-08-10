import 'package:flutter/material.dart';
import 'package:online_exam_app/core/utiles/app_color.dart';
import 'package:online_exam_app/core/utiles/app_strings.dart';
import 'package:online_exam_app/features/login/presentation/cubit/login_cubit.dart';

class RememberMeAndForgetPassword extends StatefulWidget {
  final LoginCubit loginCubit;

  const RememberMeAndForgetPassword({super.key, required this.loginCubit});

  @override
  State<RememberMeAndForgetPassword> createState() =>
      _RememberMeAndForgetPasswordState();
}

class _RememberMeAndForgetPasswordState
    extends State<RememberMeAndForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: widget.loginCubit.isRememberMe,
          onChanged: (value) {
            setState(() {
              widget.loginCubit.isRememberMe = value!;
              widget.loginCubit.setRememberMe();
            });
          },
        ),
        Text(AppStrings.rememberMe),
        Spacer(),
        InkWell(
          onTap: () {
            /// Navigator to forget Password
            // Navigator.pushNamed(context, AppRoutesName.forgetPassword);
          },
          child: Text(
            AppStrings.forgetPassword,
            style: TextStyle(
              color: AppColors.black,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
