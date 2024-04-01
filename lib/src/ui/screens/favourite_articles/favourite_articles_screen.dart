import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/src/core/notifier.dart';
import '../../../core/providers.dart';
import '../../../domain/repository/favourite_repository_impl.dart';
import '../../localizations/localization.dart';
import '../../navigator/manager.dart';
import '../../widgets/row_item.dart';

class FavouriteArticlesScreen extends StatelessWidget {
  final NavigatorManager navigatorManager;
  const FavouriteArticlesScreen({super.key, required this.navigatorManager});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)['favorites'] ?? ''),
          centerTitle: true,
        ),
        body: const Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: FavouriteArticlesList()));
  }
}

class FavouriteArticlesList extends StatelessWidget {
  const FavouriteArticlesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, ref, _) => FavouriteArticlesListView(
            favouriteArticles: ref.watch(favouriteArticlesProvider)));
  }
}

class FavouriteArticlesListView extends StatefulWidget {
  final NewsArticleState favouriteArticles;
  const FavouriteArticlesListView({super.key, required this.favouriteArticles});

  @override
  State<StatefulWidget> createState() => _FavouriteArticlesViewState();
}

class _FavouriteArticlesViewState extends State<FavouriteArticlesListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: widget.favouriteArticles.articles.length,
        separatorBuilder: (context, index) => const SizedBox(
              height: 15,
            ),
        itemBuilder: (context, index) {
          return RowItem(widget.favouriteArticles.articles[index]);
        });
  }
}
