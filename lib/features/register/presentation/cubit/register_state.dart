import 'package:flutter/material.dart';
import 'package:online_exam_app/features/register/domain/entities/user_entity.dart'; // لاستخدام GlobalKey و TextEditingController

@immutable
class RegisterState {
  final bool registerLoadingState;
  final String? registerErrorState;
  final RegisterEntity? registerEntity;

  //TextEditingController
  final TextEditingController usernameController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController phoneController;

  // Password state
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;

  // Form key
  final GlobalKey<FormState> formKey;

  const RegisterState({
    this.registerLoadingState = false,
    this.registerErrorState,
    this.registerEntity,
    required this.usernameController,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.phoneController,
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    required this.formKey,
  });

  RegisterState copyWith({
    bool? registerLoadingState,
    String? registerErrorState,
    RegisterEntity? registerEntity,
    TextEditingController? usernameController,
    TextEditingController? firstNameController,
    TextEditingController? lastNameController,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    TextEditingController? confirmPasswordController,
    TextEditingController? phoneController,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    GlobalKey<FormState>? formKey,
  }) {
    return RegisterState(
      registerLoadingState: registerLoadingState ?? this.registerLoadingState,
      registerErrorState: registerErrorState ?? this.registerErrorState,
      registerEntity: registerEntity ?? this.registerEntity,
      usernameController: usernameController ?? this.usernameController,
      firstNameController: firstNameController ?? this.firstNameController,
      lastNameController: lastNameController ?? this.lastNameController,
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      confirmPasswordController:
          confirmPasswordController ?? this.confirmPasswordController,
      phoneController: phoneController ?? this.phoneController,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      formKey: formKey ?? this.formKey,
    );
  }
}
