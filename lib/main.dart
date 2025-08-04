import 'package:flutter/material.dart';
import 'package:online_exam_app/core/cache/shared_preferences.dart';
import 'core/di/di.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  configureDependencies();
  runApp(MyApp());
}