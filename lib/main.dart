import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/core/di/di.dart';
import 'package:online_exam_app/core/utiles/bloc_observer.dart';

import 'my_app.dart';

void main() {
  configureDependencies();
  Bloc.observer = CustomBlocObserver();
  runApp(MyApp());
}
