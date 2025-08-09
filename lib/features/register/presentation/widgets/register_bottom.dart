import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/reusable_component/custom_button.dart';
import 'package:online_exam_app/features/register/presentation/cubit/register_cubit.dart';
import 'package:online_exam_app/features/register/presentation/cubit/register_state.dart';

class RegisterSubmitButton extends StatelessWidget {
  const RegisterSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (prev, curr) =>
          prev.registerLoadingState != curr.registerLoadingState,
      builder: (context, state) {
        return CustomButton(
          borderRadius: 33,
          size: Size(double.infinity, 48.h),
          backgroundColorButton: Theme.of(context).colorScheme.primary,
          onPressed: () async {
            await context.read<RegisterCubit>().register();
          },
          child: state.registerLoadingState
              ? Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                )
              : Text(
                  'Sign Up',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
        );
      },
    );
  }
}
