import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api_result/api_result.dart';
import 'package:online_exam_app/core/cache/shared_preferences.dart';
import 'package:online_exam_app/core/utiles/app_strings.dart';
import 'package:online_exam_app/features/login/domain/entities/user_model.dart';
import 'package:online_exam_app/features/login/domain/usecases/login_usecase.dart';
import 'package:online_exam_app/features/login/presentation/cubit/login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginUseCase loginUseCase;

  bool isRememberMe = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  LoginCubit({required this.loginUseCase}) : super(LoginState.initial());

  Future<void> login({String? email, String? password}) async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(isLoadingState: true,showDialogState: false) );
      await Future.delayed(Duration(seconds: 1));
      ApiResult<UserModel> isLogin = await loginUseCase.call(
        email: emailController.text,
        password: passwordController.text,
      );
      if (isLogin is ApiSuccessResult) {
        emit(state.copyWith(isLoggedState: true, showDialogState: false, isLoadingState: false));
      } else if (isLogin is ApiErrorResult) {
        emit(state.copyWith(showDialogState: true, isLoggedState: false,isLoadingState: false));
      }
    }
  }

  Future<void> setRememberMe() async {
    CacheHelper.saveData(AppStringsKey.rememberMeKey, isRememberMe);
  }

  Future<void> getRememberMe() async {
    bool? autologin = CacheHelper.getRememberMe(AppStringsKey.rememberMeKey);
    if (autologin == false) {
      emit(state.copyWith(rememberMeState: false));
    } else {
      emit(state.copyWith(rememberMeState: true));
    }
  }

  Future<void> deleteToken() async {
    CacheHelper.deleteToken(AppStringsKey.tokenKey);
  }
}