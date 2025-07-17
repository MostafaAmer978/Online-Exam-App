import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/core/reusable_component/custom_textfield.dart';
import 'package:online_exam_app/core/values/app_strings.dart';
import 'package:online_exam_app/features/register/presentation/cubit/register_cubit.dart';
import 'package:online_exam_app/features/register/presentation/cubit/register_state.dart';

class ConfirmPasswordField extends StatelessWidget {
  final FocusNode focusNode;
  final FocusNode nextFocus;
  const ConfirmPasswordField({
    super.key,
    required this.focusNode,
    required this.nextFocus,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (prev, curr) =>
          prev.isConfirmPasswordVisible != curr.isConfirmPasswordVisible,
      builder: (context, state) {
        return CustomTextFormField(
          focusNode: focusNode,
          onFieldSubmitted: (_) => nextFocus.requestFocus(),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          controller: state.confirmPasswordController,
          label: AppStrings.confirmPasswordLabelText,
          hintText: AppStrings.confirmPasswordHintText,
          obscureText: !state.isConfirmPasswordVisible,
          suffixIcon: IconButton(
            icon: Icon(
              state.isConfirmPasswordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
            ),
            onPressed: () =>
                context.read<RegisterCubit>().toggleConfirmPasswordVisibility(),
          ),
          validator: context.read<RegisterCubit>().validateConfirmPassword,
        );
      },
    );
  }
}
