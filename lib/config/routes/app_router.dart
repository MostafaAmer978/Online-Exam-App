import 'package:flutter/material.dart';
import 'package:online_exam_app/home.dart';
import 'package:online_exam_app/features/login/presentation/pages/login_screen.dart';

class AppRoutesName {
  static const String loginPage = "login";
  // static const String signUpPage = "signUp";
  // static const String forgetPassword = "ForgetPassword";
  static const String home = "Home";
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
      // case AppRoutesName.signUpPage:
      //   return MaterialPageRoute(
      //     builder: (context) {
      //       return SignUp();
      //     },
      //   );
      // case AppRoutesName.forgetPassword:
      //   return MaterialPageRoute(
      //     builder: (context) {
      //       return ForgetPassword();
      //     },);
      case AppRoutesName.home:
        return MaterialPageRoute(
          builder: (context) {
            return Home();
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
