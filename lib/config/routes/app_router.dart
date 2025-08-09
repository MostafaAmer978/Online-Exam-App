import 'package:flutter/material.dart';
import 'package:online_exam_app/config/routes/routes_name.dart';
import 'package:online_exam_app/features/register/presentation/pages/register_page.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  // final args = settings.arguments;
  switch (settings.name) {
    case RoutesName.signUpPage:
      return MaterialPageRoute(builder: (context) => const RegisterPage());

    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(child: Text('No route found ${settings.name}')),
        ),
      );
  }
}
