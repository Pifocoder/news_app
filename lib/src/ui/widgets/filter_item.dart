import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/model/articles.dart';
import '../localizations/localization.dart';

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
            AppLocalizations.of(context)[widget.query] ?? '',
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
              AppLocalizations.of(context)['apiLanguage'] ?? 'en');
        });
  }
}