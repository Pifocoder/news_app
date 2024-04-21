import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/src/domain/model/articles.dart';
import 'package:news_app/src/domain/repository/favourite_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('favorites', () {
    test('add article to favourites', () async {
      SharedPreferences.setMockInitialValues({}); //set values here
      SharedPreferences pref = await SharedPreferences.getInstance();
      FavouriteArticlesRepository repo = FavouriteArticlesRepository();
      NewsArticle article = NewsArticle(
        sourceName: "sourceName",
        author: "Muiris O'Cearbhaill",
        title: "Young male pedestrian dies after road collision on N17 in Mayo",
        description:
            "The incident took place at approximately 9.20pm yesterday evening.",
        url:
            "https://www.thejournal.ie/young-pedestrian-dies-after-road-collision-in-mayo-6341607-Mar2024/",
        urlToImage:
            "https://img2.thejournal.ie/article/6341607/river/?height=400&version=6341608",
        publishedAt: DateTime.parse("2024-03-31T08:34:21Z"),
        content:
            "LAST UPDATE|3 minutes ago\r\nA YOUNG MALE pedestrian has been killed in a road incident in Co Mayo.\r\nHe was pronounced dead at the scene after an accident on the N17 near Claremorris at approximately 9… [+776 chars]",
      );
      await repo.toggleNewsArticle(article);
      final encodedList = [
        '{"sourceName":"sourceName","author":"Muiris O\'Cearbhaill","title":"Young male pedestrian dies after road collision on N17 in Mayo","description":"The incident took place at approximately 9.20pm yesterday evening.","url":"https://www.thejournal.ie/young-pedestrian-dies-after-road-collision-in-mayo-6341607-Mar2024/","urlToImage":"https://img2.thejournal.ie/article/6341607/river/?height=400&version=6341608","publishedAt":"2024-03-31T08:34:21.000Z","content":"LAST UPDATE|3 minutes ago\\r\\nA YOUNG MALE pedestrian has been killed in a road incident in Co Mayo.\\r\\nHe was pronounced dead at the scene after an accident on the N17 near Claremorris at approximately 9… [+776 chars]"}'
      ];
      expect(pref.getStringList('favouriteArticles'), encodedList);
    });
    test('add and remove article from favourites', () async {
      SharedPreferences.setMockInitialValues({}); //set values here
      SharedPreferences pref = await SharedPreferences.getInstance();
      FavouriteArticlesRepository repo = FavouriteArticlesRepository();
      NewsArticle article = NewsArticle(
        sourceName: "sourceName",
        author: "Muiris O'Cearbhaill",
        title: "Young male pedestrian dies after road collision on N17 in Mayo",
        description:
            "The incident took place at approximately 9.20pm yesterday evening.",
        url:
            "https://www.thejournal.ie/young-pedestrian-dies-after-road-collision-in-mayo-6341607-Mar2024/",
        urlToImage:
            "https://img2.thejournal.ie/article/6341607/river/?height=400&version=6341608",
        publishedAt: DateTime.parse("2024-03-31T08:34:21Z"),
        content:
            "LAST UPDATE|3 minutes ago\r\nA YOUNG MALE pedestrian has been killed in a road incident in Co Mayo.\r\nHe was pronounced dead at the scene after an accident on the N17 near Claremorris at approximately 9… [+776 chars]",
      );
      await repo.toggleNewsArticle(article);
      await repo.toggleNewsArticle(article);
      final encodedList = [];
      expect(pref.getStringList('favouriteArticles'), encodedList);
    });
    test('add two articles and get them', () async {
      SharedPreferences.setMockInitialValues({});
      FavouriteArticlesRepository repo = FavouriteArticlesRepository();

      NewsArticle article1 = NewsArticle(
        sourceName: "HSEHSE",
        author: "Muiris O'Cearbhaill",
        title: "Young male pedestrian dies after road collision on N17 in Mayo",
        description:
            "The incident took place at approximately 9.20pm yesterday evening.",
        url: "first",
        urlToImage:
            "https://img2.thejournal.ie/article/6341607/river/?height=400&version=6341608",
        publishedAt: DateTime.parse("2024-03-31T08:34:21Z"),
        content:
            "LAST UPDATE|3 minutes ago\r\nA YOUNG MALE pedestrian has been killed in a road incident in Co Mayo.\r\nHe was pronounced dead at the scene after an accident on the N17 near Claremorris at approximately 9… [+776 chars]",
      );
      NewsArticle article2 = NewsArticle(
        sourceName: "HSE",
        author: "Muiris O'Cearbhaill",
        title: "Young male pedestrian dies after road collision on N17 in Mayo",
        description:
            "The incident took place at approximately 9.20pm yesterday evening.",
        url: "second",
        urlToImage:
            "https://img2.thejournal.ie/article/6341607/river/?height=400&version=6341608",
        publishedAt: DateTime.parse("2024-03-31T08:34:21Z"),
        content:
            "LAST UPDATE|3 minutes ago\r\nA YOUNG MALE pedestrian has been killed in a road incident in Co Mayo.\r\nHe was pronounced dead at the scene after an accident on the N17 near Claremorris at approximately 9… [+776 chars]",
      );

      await repo.toggleNewsArticle(article1);
      await repo.toggleNewsArticle(article2);

      final encodedList = [article1, article2];
      final repoArticles = await repo.getNewsArticles();
      expect(repoArticles.map((article) => jsonEncode(article.toJson())),
          encodedList.map((article) => jsonEncode(article.toJson())));
    });
  });
}
