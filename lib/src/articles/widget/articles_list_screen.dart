import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/src/articles/model/articles.dart';

import '../../localizations/localization.dart';
import '../../navigator/manager.dart';

String _formatTwoDigits(int number) {
  return number.toString().padLeft(2, '0');
}

String getArticlesUrl(query, language) {
  DateTime now = DateTime.now();
  DateTime tenDaysAgo = now.subtract(const Duration(days: 10));
  String formattedDate =
      "${tenDaysAgo.year}-${_formatTwoDigits(tenDaysAgo.month)}-${_formatTwoDigits(tenDaysAgo.day)}";
  return "https://newsapi.org/v2/everything?q=$query&from=$formattedDate&language=$language&sortBy=publishedAt&apiKey=cda6259bab7c4ba091458b5f42d5ae80";
}

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
          title: Text(AppLocalizations.of(context)['news'] ?? ""),
          centerTitle: true),
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
                          return const Text("error");
                        }
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }))
          ])));

  Future<List<NewsArticle>> loadArticles(url) async {
    HttpClient httpClient = HttpClient();
    try {
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
      HttpClientResponse response = await request.close();

      if (response.statusCode == HttpStatus.ok) {
        String responseBody = await response.transform(utf8.decoder).join();
        Map<String, dynamic> jsonData = json.decode(responseBody);
        List<NewsArticle> articles = jsonData['articles']
            .map<NewsArticle>((json) => NewsArticle.fromJson(json))
            .toList();
        return articles;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    } finally {
      httpClient.close();
    }
  }
}

class FilterItem extends StatefulWidget {
  final String query;
  final Future<List<NewsArticle>> Function(String url) loadArticles;
  final void Function(String url, String language) updateArticlesFuture;

  final String activeQuery;

  const FilterItem(
      {super.key,
      required this.query,
      required this.loadArticles,
      required this.updateArticlesFuture,
      required this.activeQuery});

  @override
  State<FilterItem> createState() => _FilterItemState();
}

class _FilterItemState extends State<FilterItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
          width: 90,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: (widget.activeQuery == widget.query)
                ? Colors.black
                : Colors.white,
            border: Border.all(
              color: Colors.black, // Border color
              width: 2, // Border width
            ),
          ),
          child: Text(
            AppLocalizations.of(context)[widget.query] ?? "",
            style: TextStyle(
              fontSize: 18.0,
              color: (widget.activeQuery == widget.query)
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
        onTap: () {
          widget.updateArticlesFuture(widget.query,
              AppLocalizations.of(context)['apiLanguage'] ?? "en");
        });
  }
}

class RowItem extends StatelessWidget {
  final NewsArticle article;
  const RowItem(this.article, {super.key});

  @override
  Widget build(BuildContext context) {
    return ArticleRow(article: article);
  }
}

class ArticleRow extends StatelessWidget {
  final NewsArticle article;

  const ArticleRow({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadImage(article.urlToImage),
      builder: (BuildContext context, AsyncSnapshot<ImageProvider> snapshot) {
        return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/full_article',
                      arguments: {"article": json.encode(article.toJson())});
                },
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200.withOpacity(0.2),
                      image: snapshot.connectionState == ConnectionState.waiting
                          ? const DecorationImage(
                              alignment: Alignment.center,
                              image: AssetImage('assets/image_loading.gif'),
                              fit: BoxFit.contain,
                            )
                          : snapshot.hasError || !snapshot.hasData
                              ? const DecorationImage(
                                  alignment: Alignment.topCenter,
                                  image: AssetImage('assets/image_error.png'),
                                  fit: BoxFit.cover,
                                )
                              : DecorationImage(
                                  alignment: Alignment.topCenter,
                                  image: snapshot.data as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                    ),
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                        child: Container(
                            color: Colors.black.withOpacity(0.5),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, bottom: 20, left: 15, right: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    article.title,
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 28.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white, // Changed to white
                                      letterSpacing: 1.2,
                                      shadows: [
                                        Shadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          blurRadius: 2,
                                          offset: const Offset(2, 2),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 120),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        makeShort(article.author),
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "${DateFormat.jm().format(article.publishedAt)} ${DateFormat.MMMMd().format(article.publishedAt)}",
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ))))));
      },
    );
  }

  String makeShort(word) {
    return word.length > 15 ? "${word.substring(0, 12)}..." : word;
  }

  Future<ImageProvider> loadImage(url) async {
    final httpClient = HttpClient();
    try {
      final request = await httpClient.headUrl(Uri.parse(url));
      final response = await request.close();
      if (response.statusCode != HttpStatus.ok) {
        return const AssetImage('assets/image_error.png');
      }
      return NetworkImage(url);
    } catch (error) {
      return const AssetImage('assets/image_error.png');
    } finally {
      httpClient.close();
    }
  }
}
