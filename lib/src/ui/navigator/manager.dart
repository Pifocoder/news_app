import 'package:flutter/material.dart';

class NavigatorManager {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  void goToNewsListScreen(BuildContext context) {
    Navigator.pushNamed(context, '/');
  }

  void goToFavouriteArticlesScreen(BuildContext context) {
    Navigator.pushNamed(context, '/favourite_articles');
  }
  void pushNamed(String routeName) {
    navigatorKey.currentState!.pushNamed(routeName);
  }

  void pop() {
    navigatorKey.currentState!.pop();
  }
}
