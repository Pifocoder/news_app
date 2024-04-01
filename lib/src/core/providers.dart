import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/repository/favourite_repository_impl.dart';
import 'notifier.dart';

final favouriteArticlesRepositoryProvider =
    Provider<FavouriteArticlesRepository>(
  (ref) => FavouriteArticlesRepository(),
);

final favouriteArticlesProvider =
    StateNotifierProvider<NewsArticleNotifier, NewsArticleState>((ref) {
  final repository = ref.watch(favouriteArticlesRepositoryProvider);
  return NewsArticleNotifier(repository);
});
