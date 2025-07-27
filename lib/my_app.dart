import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/config/routes/app_router.dart';
import 'package:online_exam_app/config/theme/app_theme.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          // theme: AppTheme.lightTheme,
          // debugShowCheckedModeBanner: false,
          initialRoute: AppRoutesName.loginPage,
          onGenerateRoute: (settings){
            return AppRoutes.onGenerate(settings);
          },
        );
      }
    );
  }
}
