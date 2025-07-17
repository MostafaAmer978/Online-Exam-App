import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/reusable_component/custom_textfield.dart';
import 'package:online_exam_app/core/values/app_strings.dart';
import 'package:online_exam_app/features/register/presentation/cubit/register_cubit.dart';
import 'package:online_exam_app/features/register/presentation/cubit/register_state.dart';
import 'package:online_exam_app/features/register/presentation/widgets/confirm_password_feild.dart';
import 'package:online_exam_app/features/register/presentation/widgets/password_feild.dart';

class RegisterTextFields extends StatefulWidget {
  const RegisterTextFields({super.key});

  @override
  State<RegisterTextFields> createState() => _RegisterTextFieldsState();
}

class _RegisterTextFieldsState extends State<RegisterTextFields> {
  final _usernameFocus = FocusNode();
  final _firstNameFocus = FocusNode();
  final _lastNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();
  final _phoneFocus = FocusNode();

  @override
  void dispose() {
    _usernameFocus.dispose();
    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    _phoneFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocSelector<RegisterCubit, RegisterState, TextEditingController>(
          selector: (state) => state.usernameController,
          builder: (context, controller) {
            return CustomTextFormField(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              controller: controller,
              label: AppStrings.userNameLabelText,
              hintText: AppStrings.userNameHintText,
              validator: context.read<RegisterCubit>().validateUsername,
              focusNode: _usernameFocus,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_firstNameFocus),
            );
          },
        ),
        SizedBox(height: 14.h),

        Row(
          children: [
            Expanded(
              child:
                  BlocSelector<
                    RegisterCubit,
                    RegisterState,
                    TextEditingController
                  >(
                    selector: (state) => state.firstNameController,
                    builder: (context, controller) {
                      return CustomTextFormField(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        controller: controller,
                        label: AppStrings.firstNameLabelText,
                        hintText: AppStrings.firstNameHintText,
                        validator: context
                            .read<RegisterCubit>()
                            .validateFirstName,
                        focusNode: _firstNameFocus,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(_lastNameFocus),
                      );
                    },
                  ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child:
                  BlocSelector<
                    RegisterCubit,
                    RegisterState,
                    TextEditingController
                  >(
                    selector: (state) => state.lastNameController,
                    builder: (context, controller) {
                      return CustomTextFormField(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        controller: controller,
                        label: AppStrings.lastNameLabelText,
                        hintText: AppStrings.lastNameHintText,
                        validator: context
                            .read<RegisterCubit>()
                            .validateLastName,
                        focusNode: _lastNameFocus,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(_emailFocus),
                      );
                    },
                  ),
            ),
          ],
        ),
        SizedBox(height: 14.h),

        BlocSelector<RegisterCubit, RegisterState, TextEditingController>(
          selector: (state) => state.emailController,
          builder: (context, controller) {
            return CustomTextFormField(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              controller: controller,
              label: AppStrings.emailLabelText,
              hintText: AppStrings.emailHintText,
              keyboardType: TextInputType.emailAddress,
              validator: context.read<RegisterCubit>().validateEmail,
              focusNode: _emailFocus,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_passwordFocus),
            );
          },
        ),
        SizedBox(height: 14.h),

        Row(
          children: [
            Expanded(
              child: PasswordField(
                focusNode: _passwordFocus,
                nextFocus: _confirmPasswordFocus,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: ConfirmPasswordField(
                focusNode: _confirmPasswordFocus,
                nextFocus: _phoneFocus,
              ),
            ),
          ],
        ),

        SizedBox(height: 14.h),

        BlocSelector<RegisterCubit, RegisterState, TextEditingController>(
          selector: (state) => state.phoneController,
          builder: (context, controller) {
            return CustomTextFormField(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              controller: controller,
              label: AppStrings.phoneLabelText,
              hintText: AppStrings.phoneHintText,
              keyboardType: TextInputType.phone,
              validator: context.read<RegisterCubit>().validatePhone,
              focusNode: _phoneFocus,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) {
                context.read<RegisterCubit>().register();
              },
            );
          },
        ),
      ],
    );
  }
}
