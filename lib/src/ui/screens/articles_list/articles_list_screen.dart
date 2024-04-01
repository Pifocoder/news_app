import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/src/domain/model/articles.dart';

import 'package:news_app/src/ui/localizations/localization.dart';
import 'package:news_app/src/ui/navigator/manager.dart';
import 'package:news_app/src/ui/widgets/filter_item.dart';
import 'package:news_app/src/ui/widgets/row_item.dart';

import '../../../data/api/articles.dart';

class NewsListScreen extends StatefulWidget {
  final NavigatorManager navigatorManager;

  const NewsListScreen({super.key, required this.navigatorManager});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  late Future<List<NewsArticle>> articlesFuture;
  String activeQuery = queries[0];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    updateArticlesFuture(
        queries[0], AppLocalizations.of(context)['apiLanguage']);
  }

  void updateArticlesFuture(query, language) {
    setState(() {
      activeQuery = query;
    });
    setState(() {
      articlesFuture = loadArticles(getArticlesUrl(query, language));
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context)['news'] ?? ''),
          centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, size: 35),
            onPressed: () {
              widget.navigatorManager.goToFavouriteArticlesScreen(context);
            },
          ),
        ],),
      body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(children: [
            const SizedBox(height: 20),
            SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return FilterItem(
                        query: queries[index],
                        loadArticles: loadArticles,
                        updateArticlesFuture: updateArticlesFuture,
                        activeQuery: activeQuery);
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 15,
                  ),
                  itemCount: queries.length,
                )),
            const SizedBox(height: 20),
            Expanded(
                flex: 5,
                child: FutureBuilder(
                    future: articlesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          List<NewsArticle> articles = snapshot.data!;
                          return ListView.separated(
                            itemBuilder: (context, index) {
                              return RowItem(articles[index]);
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 15,
                            ),
                            itemCount: articles.length,
                          );
                        } else {
                          return const Text('error');
                        }
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }))
          ]))
  );
}
