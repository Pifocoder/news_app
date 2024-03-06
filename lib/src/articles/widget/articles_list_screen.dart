import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/src/articles/model/articles.dart';

class NewsListScreen extends StatelessWidget {
  const NewsListScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('News'), centerTitle: true),
        body: ListView.separated(
          itemBuilder: (context, index) => RowItem(articles[index]),
          separatorBuilder: (context, index) => const SizedBox(
            height: 15,
          ),
          itemCount: articles.length,
        ),
      );
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
        return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
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
                            color: Colors.grey.withOpacity(0.5),
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
                                        article.author,
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "${DateFormat.jm().format(article.publishedAt)} ${DateFormat.yMMMMd().format(article.publishedAt)}",
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

  Future<ImageProvider> loadImage(url) async {
    try {
      final httpClient = HttpClient();
      final request = await httpClient.headUrl(Uri.parse(url));
      final response = await request.close();
      if (response.statusCode == HttpStatus.notFound) {
        return const AssetImage('assets/image_error.png');
      }
      return NetworkImage(url);
    } catch (error) {
      return const AssetImage('assets/image_error.png');
    }
  }
}
