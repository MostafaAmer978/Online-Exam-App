import 'package:flutter/material.dart';
import 'package:online_exam_app/config/routes/base_route.dart';
import 'package:online_exam_app/features/register/presentation/pages/register_page.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  // final args = settings.arguments;
  switch (settings.name) {
    case RegisterPage.routeName:
      return BaseRoute(page: RegisterPage());

    default:
      return BaseRoute(
        page: Scaffold(
          body: Center(child: Text('No route found ${settings.name}')),
        ),
      );
  }
}
