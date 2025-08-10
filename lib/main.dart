import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/config/app_cubit/app_cubit.dart';
import 'package:online_exam_app/core/cache/lbar_prefs.dart';
import 'package:online_exam_app/core/cache/shared_preferences.dart';
import 'package:online_exam_app/core/di/di.dart';
import 'package:online_exam_app/core/utiles/bloc_observer.dart';

import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.init();
  // message Mostafa
  //most we use lbar prefs or cachehelper because they are the same
  await CacheHelper.init();
  configureDependencies();
  Bloc.observer = CustomBlocObserver();
  final appCubit = getIt<AppCubit>();
  runApp(BlocProvider.value(value: appCubit..loadToken(), child: MyApp()));
}
