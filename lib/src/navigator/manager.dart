import 'package:flutter/material.dart';

class NavigatorManager {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void pushNamed(String routeName) {
    navigatorKey.currentState!.pushNamed(routeName);
  }

  void pop() {
    navigatorKey.currentState!.pop();
  }
}
