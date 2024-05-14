import 'package:flutter/material.dart';
import 'package:news_app/src/screens/profile/email_check.dart';

import '../articles/widget/articles_list_screen.dart';
import '../navigator/manager.dart';
import '../screens/mock.dart';


class App extends StatelessWidget {
  final navigatorManager = NavigatorManager();

  App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    navigatorKey: navigatorManager.navigatorKey,
    routes: {
      '/': (context) => Home(navigatorManager: navigatorManager),
      '/movement': (context) =>
          Home(navigatorManager: navigatorManager),
      '/profile': (context) =>
          EmailCheck(navigatorManager: navigatorManager),
      '/scan' : (context) =>
          Home(navigatorManager: navigatorManager),
    },
    initialRoute: '/profile',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
    ),
  );
}