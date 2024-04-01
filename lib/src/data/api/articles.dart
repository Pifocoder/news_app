import 'dart:convert';
import 'dart:io';

import '../../domain/model/articles.dart';

String _formatTwoDigits(int number) {
  return number.toString().padLeft(2, '0');
}

String getArticlesUrl(query, language) {
  DateTime now = DateTime.now();
  DateTime tenDaysAgo = now.subtract(const Duration(days: 10));
  String formattedDate =
      '${tenDaysAgo.year}-${_formatTwoDigits(tenDaysAgo.month)}-${_formatTwoDigits(tenDaysAgo.day)}';
  return 'https://newsapi.org/v2/everything?q=$query&from=$formattedDate&language=$language&sortBy=publishedAt&apiKey=cda6259bab7c4ba091458b5f42d5ae80';
}

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
