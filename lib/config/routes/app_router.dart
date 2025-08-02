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

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  // final args = settings.arguments;
  switch (settings.name) {
    case RegisterPage.routeName:
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => getIt<RegisterCubit>(),
          child: const RegisterPage(),
        ),
      );
    case HomePage.routeName:
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => getIt<HomeCubit>(),
          child: HomePage(),
        ),
      );
    case SplashPage.routeName:
      return MaterialPageRoute(builder: (context) => const SplashPage());
    case ExamScoreView.routeName:
      final Map<String, dynamic> results =
          settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (context) => ExamScoreView(results: results),
      );

    case ExamsDetails.routeName:
      final ExamsEntity exam = settings.arguments as ExamsEntity;
      return MaterialPageRoute(
        builder: (context) => ExamsDetails(entity: exam),
      );
    case ExamsPage.routeName:
      final SubjectsEntity subject = settings.arguments as SubjectsEntity;
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => getIt<ExamsCubit>()..getExamsById(),
          child: ExamsPage(subject: subject),
        ),
      );
    case QuestionsView.routeName:
      // final QuestionsEntity subject =
      //       settings.arguments as QuestionsEntity;
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => getIt<QuestionsCubit>()..getQuestionById(),
          child: QuestionsView(),
        ),
      );
    // BlocProvider(
    //           create: (context) => getIt<HomeCubit>(),
    //           child: HomePage(),
    //         ),
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(child: Text('No route found ${settings.name}')),
        ),
      );
  }
}
