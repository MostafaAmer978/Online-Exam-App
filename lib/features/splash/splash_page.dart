import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/config/app_cubit/app_cubit.dart';
import 'package:online_exam_app/config/routes/app_router.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit, AppState>(
      listener: (context, state) {
        print("AppState changed: isAuthenticated = ${state.isAuthenticated}");
        if (state.isAuthenticated) {
          Navigator.pushReplacementNamed(context, AppRoutesName.home);
        } else {
          Navigator.pushReplacementNamed(context, AppRoutesName.register);
        }
      },
      child: const Scaffold(
        body: Center(child: CircularProgressIndicator.adaptive()),
      ),
    );
  }
}
