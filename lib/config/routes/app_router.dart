import 'package:flutter/material.dart';
import 'package:online_exam_app/features/login/presentation/pages/login_screen.dart';

class AppRoutesName {
  static const String loginPage = "login";
  static const String signUpPage = "signUp";
}


class AppRoutes {
  static Route<dynamic>? onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesName.loginPage:
        return MaterialPageRoute(
          builder: (context) {
            return LoginScreen();
          },
        );
      default:
        return MaterialPageRoute(
          builder: (context) {
            return unDefineRoute();
          },
        );
    }
  }

  static Widget unDefineRoute() {
    return Scaffold(body: Center(child: Text("RouteName not Found")));
  }
}
