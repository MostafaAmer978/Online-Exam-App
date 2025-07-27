import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/core/di/di.dart';
import 'package:online_exam_app/features/login/presentation/cubit/login_cubit.dart';
import 'package:online_exam_app/features/login/presentation/cubit/login_state.dart';

class LoginScreen extends StatelessWidget {
  final LoginCubit loginCubit = getIt.get<LoginCubit>();
  final GlobalKey formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  /// Add Package ScreenUtils

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => loginCubit,
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (BuildContext context, state) {
          // TODO: Listener
        },
        builder: (BuildContext context, state) {
          return SafeArea(child: Scaffold());
        },
      ),
    );
  }
}

