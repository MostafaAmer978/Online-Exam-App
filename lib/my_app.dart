import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/config/routes/app_router.dart' as AppRouter;
import 'package:online_exam_app/config/theme/app_theme.dart';
import 'package:online_exam_app/features/splash/splash_page.dart';

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
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        onGenerateRoute: AppRouter.onGenerateRoute,
        //TODO youe to add here initial route as login
        initialRoute: SplashPage.routeName,
        // home: SafeArea(
        //   child: Scaffold()
        // ),
      ),
    );
  }

  // String _getInitialRoute() {
  //   final token = getIt<SecureStorageService>().readToken();
  //   return token != null && token.isNotEmpty ? HomePage.routeName : RegisterPage.routeName;
  // }
}
