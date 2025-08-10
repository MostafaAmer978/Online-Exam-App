import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/config/routes/app_router.dart';
import 'package:online_exam_app/core/values/app_strings.dart';
import 'package:online_exam_app/features/register/presentation/cubit/register_cubit.dart';
import 'package:online_exam_app/features/register/presentation/cubit/register_state.dart';
import 'package:online_exam_app/features/register/presentation/widgets/form_wapper.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listenWhen: (prev, curr) =>
          prev.registerEntity != curr.registerEntity ||
          prev.registerErrorState != curr.registerErrorState,
      listener: (context, state) {
        if (state.registerEntity != null) {
          Navigator.pushNamed(context, AppRoutesName.home);
          return showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.success(
              backgroundColor: Theme.of(context).colorScheme.primary,
              message: AppStrings.userCreatedSuccessfully,
            ),
          );

          // TODO: Navigate to login
        } else if (state.registerErrorState != null) {
          return showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(message: 'Error: ${state.registerErrorState}'),
          );
        }
      },
      child: const RegisterFormWrapper(),
    );
  }
}
