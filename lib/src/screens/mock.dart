import 'package:flutter/material.dart';

import '../navigator/manager.dart';

class Home extends StatelessWidget {
  final NavigatorManager navigatorManager;

  const Home({super.key, required this.navigatorManager});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
          child: Text('Home'),
        ),
      );
  }
}