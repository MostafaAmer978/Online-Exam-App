import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/config/app_cubit/app_cubit.dart';
import 'package:online_exam_app/features/home/views/home_page.dart';
import 'package:online_exam_app/features/register/presentation/pages/register_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  static const String routeName = 'splash';
  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit, AppState>(
      listener: (context, state) {
        print("AppState changed: isAuthenticated = ${state.isAuthenticated}");
        if (state.isAuthenticated) {
          Navigator.pushReplacementNamed(context, HomePage.routeName);
        } else {
          Navigator.pushReplacementNamed(context, RegisterPage.routeName);
        }
      },
      child: const Scaffold(
        body: Center(child: CircularProgressIndicator.adaptive()),
      ),
    );
  }
}
