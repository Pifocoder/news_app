import 'package:flutter/material.dart';

class NavigatorManager {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  void goToProfile(BuildContext context) {
    Navigator.pushNamed(context, '/profile');
  }

  void goToHome(BuildContext context) {
    Navigator.pushNamed(context, '/home');
  }

  void pushNamed(String routeName) {
    navigatorKey.currentState!.pushNamed(routeName);
  }

  void pop() {
    navigatorKey.currentState!.pop();
  }
}