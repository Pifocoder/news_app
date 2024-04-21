import 'package:flutter/material.dart';

import '../../domain/model/articles.dart';
import 'article_row.dart';

class RowItem extends StatelessWidget {
  final NewsArticle article;
  const RowItem(this.article, {super.key});

  @override
  Widget build(BuildContext context) {
    return ArticleRow(article: article);
  }
}
