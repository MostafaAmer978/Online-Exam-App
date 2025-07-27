import 'package:flutter/material.dart';

import 'core/di/di.dart';
import 'my_app.dart';

void main() {
  configureDependencies();
  runApp(MyApp());
}
