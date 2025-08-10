import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/config/routes/app_router.dart';
import 'package:online_exam_app/core/di/di.dart';
import 'package:online_exam_app/core/utiles/app_strings.dart';
import 'package:online_exam_app/features/home/views/home_page.dart';
import 'package:online_exam_app/features/login/presentation/cubit/login_cubit.dart';
import 'package:online_exam_app/features/login/presentation/cubit/login_state.dart';
import 'package:online_exam_app/features/login/presentation/widgets/login_button_create_account.dart';
import 'package:online_exam_app/features/login/presentation/widgets/text_form_fields.dart';
import 'package:online_exam_app/features/login/presentation/widgets/remember_me_forget_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginCubit loginCubit = getIt.get<LoginCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => loginCubit..getRememberMe(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (BuildContext context, state) {
          if (state.showDialogState == true) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(AppStrings.error),
                  content: Text("Invalid credentials"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(AppStrings.cancel),
                    ),
                  ],
                );
              },
            );
          } else if (state.isLoggedState == true) {
            /// Navigator to HomeScreen
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutesName.home,
              (route) => false,
            );
          }
        },
        builder: (BuildContext context, state) {
          if (state.rememberMeState == true) {
            return HomePage();
          } else {
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(title: Text(AppStrings.login)),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: loginCubit.formKey,
                      child: Column(
                        children: [
                          TextFormFields(loginCubit: loginCubit),
                          SizedBox(height: 5.h),
                          RememberMeAndForgetPassword(loginCubit: loginCubit),
                          SizedBox(height: 48.h),
                          LoginButtonAndCreateAccount(loginCubit: loginCubit),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  dispose() {
    loginCubit.emailController.dispose();
    loginCubit.passwordController.dispose();
    super.dispose();
  }
}
