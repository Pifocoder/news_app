import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/src/domain/model/articles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/repository/favourite_repository_impl.dart';
import 'notifier.dart';

// final sharedPrefs = Provider.autoDispose.family<String, FavouriteArticlesRepository>((ref, repo) {
//   FavouriteArticlesRepository repository
// });
final favouriteArticlesRepositoryProvider = Provider<FavouriteArticlesRepository>(
      (ref) => FavouriteArticlesRepository(ref),
);
final favouriteArticlesProvider = StateNotifierProvider<NewsArticleNotifier, NewsArticleState>((ref) {
  final repository = ref.watch(favouriteArticlesRepositoryProvider);
  return NewsArticleNotifier(repository);
});