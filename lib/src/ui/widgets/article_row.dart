import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:news_app/src/core/providers.dart';

import '../../domain/model/articles.dart';
import '../screens/articles_list/articles_list_screen.dart';
import 'article_preview.dart';

class ArticleRow extends ConsumerWidget {
  final NewsArticle article;

  const ArticleRow({super.key, required this.article});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final heartAnimationController = AnimationControllerProvider.of(context)?.controller;
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/full_article',
                  arguments: {'article': json.encode(article.toJson())});
            },
            child: SizedBox(
                    height: 240,
                    child: Stack(children: [
                      SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Hero(
                          tag: 'articleImage${article.url}',
                          child: ArticlePreviewImage(imageUrl: article.urlToImage),
                        )
                      ),
                      BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                          child: Container(
                              color: Colors.black.withOpacity(0.5),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 20, left: 15, right: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                            if (heartAnimationController != null){
                                                heartAnimationController.forward().then((value) =>  heartAnimationController.reverse());
                                            }
                                            //ref.read(favouriteArticlesRepositoryProvider).toggleNewsArticle(article);
                                          },
                                        ),
                                      ],
                                    ),
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
                              )))
                    ]))));
  }

  String makeShort(word) {
    return word.length > 13 ? '${word.substring(0, 10)}...' : word;
  }
}
