import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/config/routes/app_router.dart' as AppRouter;
import 'package:online_exam_app/config/routes/routes_name.dart';
import 'package:online_exam_app/config/theme/app_theme.dart';
import 'package:online_exam_app/core/di/di.dart';
import 'package:online_exam_app/features/register/presentation/cubit/register_cubit.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final RegisterCubit registerCubit = getIt.get<RegisterCubit>();
    return BlocProvider(
      create: (context) => registerCubit,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: RoutesName.signUpPage,
          // home: SafeArea(
          //   child: Scaffold()
          // ),
        ),
      ),
    );
  }
}
