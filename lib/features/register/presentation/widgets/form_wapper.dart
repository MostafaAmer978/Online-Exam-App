import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/features/register/presentation/cubit/register_cubit.dart';
import 'package:online_exam_app/features/register/presentation/cubit/register_state.dart';
import 'package:online_exam_app/features/register/presentation/widgets/already_have_account.dart';
import 'package:online_exam_app/features/register/presentation/widgets/register_bottom.dart';
import 'package:online_exam_app/features/register/presentation/widgets/register_text_feilds.dart';

class RegisterFormWrapper extends StatelessWidget {
  const RegisterFormWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: BlocBuilder<RegisterCubit, RegisterState>(
        buildWhen: (prev, curr) => prev.formKey != curr.formKey,
        builder: (context, state) {
          return Form(
            key: state.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const RegisterTextFields(),

                SizedBox(height: 12.h),

                const RegisterSubmitButton(),

                SizedBox(height: 20.h),

                alreadyHaveAnAccount(context: context),
              ],
            ),
          );
        },
      ),
    );
  }
}
