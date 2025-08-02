import 'package:flutter/material.dart';

AppBar buildAppBar({
  required String title,
  required BuildContext context,
  bool isNotification = false,
  bool onTap = false,
  bool isBack = false,
  String routeName = '',
  Widget notificationWidget = const Icon(
    Icons.notifications,
  ),
}) {
  return AppBar(
    actions: [
      isNotification
          ? Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: notificationWidget,
            )
          : Container(),
    ],
    leading: isBack
        ? GestureDetector(
            onTap: () {
              onTap
                  ? Navigator.pop(context)
                  : Navigator.pushNamed(
                      context,
                      routeName,
                    );
            },
            child: Icon(Icons.arrow_back_ios_new),
          )
        : null,
    // centerTitle: true,
    title: Text(
      title,
      style: Theme.of(context).textTheme.titleLarge,
    ),
  );
}
