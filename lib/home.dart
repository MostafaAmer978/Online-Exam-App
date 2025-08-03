import 'package:flutter/material.dart';
import 'package:online_exam_app/core/cache/shared_preferences.dart';
import 'package:online_exam_app/core/utiles/app_strings.dart';

import 'config/routes/app_router.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Column(
        children: [
          Text("${CacheHelper.getToken(AppStringsKey.tokenKey)}"),
          Text("${CacheHelper.getRememberMe(AppStringsKey.rememberMeKey)}"),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {

              });
             CacheHelper.saveData(AppStringsKey.rememberMeKey , false);
              Navigator.pushNamedAndRemoveUntil(context, AppRoutesName.loginPage,(route) => false,);
            },
            child: Text("Logout"),
          ),
        ],
      ),
    );
  }
}
