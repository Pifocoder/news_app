import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../articles/widget/articles_list_screen.dart';
import '../articles/widget/full_article_screen.dart';
import '../localizations/localization.dart';
import '../navigator/manager.dart';

class App extends StatelessWidget {
  final navigatorManager = NavigatorManager();

  App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: const <Locale>[
          Locale('en', ''),
          Locale('ru', ''),
        ],
        navigatorKey: navigatorManager.navigatorKey,
        initialRoute: '/',
        routes: {
          '/': (context) => NewsListScreen(navigatorManager: navigatorManager),
          '/full_article': (context) =>
              FullArticleScreen(navigatorManager: navigatorManager),
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        ),
        debugShowCheckedModeBanner: false,
      );
}
