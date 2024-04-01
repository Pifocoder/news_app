import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:news_app/src/core/providers.dart';

import '../../domain/model/articles.dart';

class ArticleRow extends ConsumerWidget {
  final NewsArticle article;

  const ArticleRow({super.key, required this.article});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: loadImage(article.urlToImage),
      builder: (BuildContext context, AsyncSnapshot<ImageProvider> snapshot) {
        return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/full_article',
                      arguments: {'article': json.encode(article.toJson())});
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          article.title,
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 28.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            letterSpacing: 1.2,
                                            shadows: [
                                              Shadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                blurRadius: 2,
                                                offset: const Offset(2, 2),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          ref
                                                      .watch(
                                                          favouriteArticlesProvider)
                                                      .articles
                                                      .indexWhere(
                                                          (repoArticle) =>
                                                              article.url ==
                                                              repoArticle
                                                                  .url) >=
                                                  0
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          size: 35,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          ref
                                              .read(favouriteArticlesProvider
                                                  .notifier)
                                              .toggleNewsArticle(article);
                                          //ref.read(favouriteArticlesRepositoryProvider).toggleNewsArticle(article);
                                        },
                                      ),
                                    ],
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
                                        '${DateFormat.jm().format(article.publishedAt)} ${DateFormat.MMMMd().format(article.publishedAt)}',
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
    return word.length > 13 ? '${word.substring(0, 10)}...' : word;
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
