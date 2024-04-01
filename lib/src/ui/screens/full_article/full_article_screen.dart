import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:news_app/src/ui/localizations/localization.dart';
import 'package:news_app/src/ui/navigator/manager.dart';
import 'package:news_app/src/domain/model/articles.dart';

import '../../../data/api/images.dart';
import '../../../data/api/launch.dart';

class FullArticleScreen extends StatelessWidget {
  final NavigatorManager navigatorManager;

  const FullArticleScreen({super.key, required this.navigatorManager});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final articleJson = args?['article'] ?? '{}';
    final article = NewsArticle.fromJson(json.decode(articleJson));

    return Scaffold(
        appBar: AppBar(
            title: Text(AppLocalizations.of(context)['article'] ?? ''),
            centerTitle: true),
        body: Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 40),
            child: ListView(children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FutureBuilder(
                      future: loadImage(article.urlToImage),
                      builder: (BuildContext context,
                          AsyncSnapshot<ImageProvider> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Image(
                            image: AssetImage('assets/image_loading.gif'),
                            fit: BoxFit.cover,
                            width: double.infinity,
                          );
                        } else {
                          if (snapshot.hasError || !snapshot.hasData) {
                            return Container();
                          } else {
                            return Image(
                              image: snapshot.data as ImageProvider,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            );
                          }
                        }
                      })),
              const SizedBox(height: 20),
              Text(
                article.title,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Author: ${article.author}',
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                article.description,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  launchURL(article.url);
                },
                child: const Text(
                  'More...',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ])));
  }
}
