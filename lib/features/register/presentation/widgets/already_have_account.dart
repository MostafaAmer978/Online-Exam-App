import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:online_exam_app/core/values/app_strings.dart';

Widget alreadyHaveAnAccount({required BuildContext context}) {
  return Center(
    child: Text.rich(
      TextSpan(
        text: AppStrings.alreadyHaveAccount,
        style: Theme.of(context).textTheme.titleSmall!,
        children: [
          TextSpan(
            text: AppStrings.loginTitle,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
            // TODO: Add recognizer to navigate to login
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
        ],
      ),
    ),
  );
}
