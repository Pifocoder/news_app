import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/src/core/providers.dart';
import 'package:news_app/src/domain/repository/favourite_repository_impl.dart';

import '../domain/model/articles.dart';
class NewsArticleState extends Equatable {
  final List<NewsArticle> articles;

  const NewsArticleState({
    required this.articles,
  });
  const NewsArticleState.initial({
    this.articles = const [],
  });

  NewsArticleState copyWith({
    List<NewsArticle>? articles,
  }) {
    return NewsArticleState(
      articles: articles ?? this.articles,
    );
  }

  @override
  List<Object> get props => [articles];
}

class NewsArticleNotifier extends StateNotifier<NewsArticleState> {
  final FavouriteArticlesRepository _repository;

  NewsArticleNotifier(this._repository) : super(const NewsArticleState.initial()) {
    getNewsArticles();
  }

  Future<void> toggleNewsArticle(NewsArticle article) async {
    await _repository.toggleNewsArticle(article);
    getNewsArticles();
  }

  void getNewsArticles() async {
    final articles = await _repository.getNewsArticles();
    state = state.copyWith(articles: articles);
  }
}