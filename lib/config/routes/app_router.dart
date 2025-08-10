import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/core/di/di.dart';
import 'package:online_exam_app/features/exams/domain/entities/exams_exntity.dart';
import 'package:online_exam_app/features/exams/presentation/cubit/exams_cubit.dart';
import 'package:online_exam_app/features/exams/presentation/pages/exams_page.dart';
import 'package:online_exam_app/features/exams/presentation/widgets/exams_details.dart';
import 'package:online_exam_app/features/home/home_cubit/home_cubit.dart';
import 'package:online_exam_app/features/home/tabs/explore_tab/domain/entities/subjects_entity.dart';
import 'package:online_exam_app/features/home/views/home_page.dart';
import 'package:online_exam_app/features/question/presentation/cubit/questions_view_model/questions_cubit.dart';
import 'package:online_exam_app/features/question/presentation/views/exam_score_view.dart';
import 'package:online_exam_app/features/question/presentation/views/questions_view.dart';
import 'package:online_exam_app/features/register/presentation/cubit/register_cubit.dart';
import 'package:online_exam_app/features/register/presentation/pages/register_page.dart';
import 'package:online_exam_app/features/splash/splash_page.dart';
import 'package:online_exam_app/features/login/presentation/pages/login_screen.dart';

class AppRoutesName {
  static const String loginPage = "login";
  // static const String signUpPage = "signUp";
  // static const String forgetPassword = "ForgetPassword";
  static const String splash = "Splash";
  static const String register = "Register";
  static const String exams = "exams";
  static const String questions = "questions";
  static const String subjects = "subjects";
  static const String examsDetails = "examsDetails";
  static const String examsScore = "examsScore";
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

      // case AppRoutesName.home:
      //   return MaterialPageRoute(
      //     builder: (context) {
      //       return Home();
      //     },
      //   );
      case AppRoutesName.register:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<RegisterCubit>(),
            child: const RegisterPage(),
          ),
        );
      case AppRoutesName.home:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<HomeCubit>(),
            child: HomePage(),
          ),
        );
      case AppRoutesName.splash:
        return MaterialPageRoute(builder: (context) => const SplashPage());
      case AppRoutesName.examsScore:
        final Map<String, dynamic> results =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => ExamScoreView(results: results),
        );

      case AppRoutesName.examsDetails:
        final ExamsEntity exam = settings.arguments as ExamsEntity;
        return MaterialPageRoute(
          builder: (context) => ExamsDetails(entity: exam),
        );
      case AppRoutesName.exams:
        final SubjectsEntity subject = settings.arguments as SubjectsEntity;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<ExamsCubit>()..getExamsById(),
            child: ExamsPage(subject: subject),
          ),
        );
      case AppRoutesName.questions:
        // final QuestionsEntity subject =
        //       settings.arguments as QuestionsEntity;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<QuestionsCubit>()..getQuestionById(),
            child: QuestionsView(),
          ),
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
