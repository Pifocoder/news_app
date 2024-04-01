import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:news_app/src/ui/screens/articles_list/articles_list_screen.dart';
import 'package:news_app/src/ui/screens/full_article/full_article_screen.dart';
import 'package:news_app/src/ui/localizations/localization.dart';
import 'package:news_app/src/ui/navigator/manager.dart';

import '../screens/favourite_articles/favourite_articles_screen.dart';

class App extends StatelessWidget {
  final navigatorManager = NavigatorManager();

  App({super.key});

  @override
  Widget build(BuildContext context) =>
  ProviderScope(
  child: MaterialApp(
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
          '/favourite_articles': (context) =>  FavouriteArticlesScreen(navigatorManager: navigatorManager),
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        ),
        debugShowCheckedModeBanner: false,
      )
  );
}
