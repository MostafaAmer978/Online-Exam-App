import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api_rasult/api_result.dart';
import 'package:online_exam_app/core/values/app_strings.dart';
import 'package:online_exam_app/features/register/domain/entities/user_entity.dart';
import 'package:online_exam_app/features/register/domain/usecases/register_user_case.dart';
import 'package:online_exam_app/features/register/presentation/cubit/register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  RegisterUserCase registerUserCase;

  RegisterCubit(this.registerUserCase)
    : super(
        RegisterState(
          usernameController: TextEditingController(),
          firstNameController: TextEditingController(),
          lastNameController: TextEditingController(),
          emailController: TextEditingController(),
          passwordController: TextEditingController(),
          confirmPasswordController: TextEditingController(),
          phoneController: TextEditingController(),
          formKey: GlobalKey<FormState>(),
        ),
      );

  Future<void> register() async {
    if (!state.formKey.currentState!.validate()) {
      emit(state.copyWith(registerErrorState: 'Please fill all the fields'));
      return;
    }

    final String username = state.usernameController.text;
    final String firstName = state.firstNameController.text;
    final String lastName = state.lastNameController.text;
    final String email = state.emailController.text;
    final String password = state.passwordController.text;
    final String rePassword = state.confirmPasswordController.text;
    final String phone = state.phoneController.text;

    emit(state.copyWith(registerLoadingState: true));
    final result = await registerUserCase.call(
      username,
      firstName,
      lastName,
      email,
      password,
      rePassword,
      phone,
    );

    switch (result) {
      case ApiSuccessResult<RegisterEntity>():
        emit(
          state.copyWith(
            registerLoadingState: false,
            registerEntity: result.data,
            registerErrorState: null,
          ),
        );
        clearForm();
        log(result.data.email.toString());
      case ApiErrorResult():
        emit(
          state.copyWith(
            registerLoadingState: false,
            registerErrorState: result.errorMessage,
            registerEntity: null,
          ),
        );
    }
  }

  void clearForm() {
    state.usernameController.clear();
    state.firstNameController.clear();
    state.lastNameController.clear();
    state.emailController.clear();
    state.passwordController.clear();
    state.confirmPasswordController.clear();
    state.phoneController.clear();
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void toggleConfirmPasswordVisibility() {
    emit(
      state.copyWith(isConfirmPasswordVisible: !state.isConfirmPasswordVisible),
    );
  }

  @override
  Future<void> close() {
    state.usernameController.dispose();
    state.firstNameController.dispose();
    state.lastNameController.dispose();
    state.emailController.dispose();
    state.passwordController.dispose();
    state.confirmPasswordController.dispose();
    state.phoneController.dispose();
    return super.close();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email cannot be empty';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password cannot be empty';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm Password cannot be empty';
    }
    if (value != state.passwordController.text) return 'Passwords do not match';
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Phone number cannot be empty';
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) return AppStrings.emptyUserName;
    return null;
  }

  String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) return AppStrings.emptyFirstName;
    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.isEmpty) return AppStrings.emptyLastName;
    return null;
  }
}
