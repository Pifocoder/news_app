import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/articles.dart';
import 'favourite_repository.dart';

class FavouriteArticlesRepository implements IFavouriteArticlesRepository {
  static const favouriteArticles = 'favouriteArticles';
  FavouriteArticlesRepository();

  @override
  Future<void> saveNewsArticles(List<NewsArticle> articles) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStringList =
        articles.map((article) => jsonEncode(article.toJson())).toList();
    await prefs.setStringList(favouriteArticles, jsonStringList);
  }

  @override
  Future<List<NewsArticle>> getNewsArticles() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStringList = prefs.getStringList(favouriteArticles) ?? [];
    return jsonStringList
        .map((jsonString) => NewsArticle.fromJson(jsonDecode(jsonString)))
        .toList();
  }

  @override
  Future<void> toggleNewsArticle(NewsArticle article) async {
    final articles = await getNewsArticles();
    final existingArticleIndex =
        articles.indexWhere((a) => a.url == article.url);
    if (existingArticleIndex == -1) {
      // Article doesn't exist, add it to the list
      articles.add(article);
    } else {
      // Article already exists, remove it from the list
      articles.removeAt(existingArticleIndex);
    }
    await saveNewsArticles(articles);
  }
}
