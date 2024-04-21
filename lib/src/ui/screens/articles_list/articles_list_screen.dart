
import 'package:flutter/material.dart';
import 'package:news_app/src/domain/model/articles.dart';

import 'package:news_app/src/ui/localizations/localization.dart';
import 'package:news_app/src/ui/navigator/manager.dart';
import 'package:news_app/src/ui/screens/articles_list/widgets/search_app_bar.dart';
import 'package:news_app/src/ui/widgets/filter_item.dart';
import 'package:news_app/src/ui/widgets/row_item.dart';

import '../../../data/api/articles.dart';

class NewsListScreen extends StatefulWidget {
  final NavigatorManager navigatorManager;

  const NewsListScreen({super.key, required this.navigatorManager});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen>
    with TickerProviderStateMixin {
  late Future<List<NewsArticle>> articlesFuture;
  late Map<String, String> activeQuery;

  late AnimationController _heartIconController;

  @override
  void initState() {
    super.initState();
    activeQuery =  {
      'q': 'coffee',
      'from': formatDateTimeApi(DateTime.now()),
      'to': formatDateTimeApi(DateTime.now().subtract(const Duration(days: 10))),
    };
    _heartIconController = AnimationController(
      duration: const Duration(milliseconds: 320),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _heartIconController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _updateArticlesFuture(activeQuery, AppLocalizations.of(context)['apiLanguage']);
  }

  void _updateActiveQuery(String name, String value) {
    final newQuery = activeQuery;
    newQuery[name] = value;
    setState(() {
      activeQuery= newQuery;
    });
    _updateArticlesFuture(
        activeQuery, AppLocalizations.of(context)['apiLanguage']);
  }

  void _updateArticlesFuture(query, language) {
    setState(() {
      articlesFuture = loadArticles(getArticlesUrl(query, language));
    });
  }

  @override
  Widget build(BuildContext context) => AnimationControllerProvider(
      controller: _heartIconController,
      child: Scaffold(
          body: CustomScrollView(slivers: [
                SliverPersistentHeader(
                  delegate: SliverSearchAppBar(navigatorManager: widget.navigatorManager, queryName: "q",
                    activeQuery: activeQuery,
                    updateActiveQuery: _updateActiveQuery),
                  pinned: true,
                ),
                SliverToBoxAdapter(
                  child: LimitedBox(
                    maxHeight: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FilterItem(
                          query: "from",
                          activeQuery: activeQuery,
                          updateActiveQuery: _updateActiveQuery,
                        ),
                        FilterItem(
                          query: "to",
                          activeQuery: activeQuery,
                          updateActiveQuery: _updateActiveQuery,
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                  FutureBuilder(
                      future: articlesFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            List<NewsArticle> articles = snapshot.data!;
                            return SliverList.separated(
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: const EdgeInsets.only(left: 10, right: 10),
                                child: RowItem(articles[index])
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 15,
                              ),
                              itemCount: articles.length,
                            );
                          } else {
                            return const SliverToBoxAdapter(child:  Text('error'));
                          }
                        } else {
                          return const SliverToBoxAdapter(child: Center(
                              child: CircularProgressIndicator()));
                        }
                      }),

              ])));
}

class AnimationControllerProvider extends InheritedWidget {
  final AnimationController controller;

  const AnimationControllerProvider({
    super.key,
    required this.controller,
    required super.child,
  });

  static AnimationControllerProvider? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<AnimationControllerProvider>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
