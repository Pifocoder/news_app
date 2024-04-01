import 'package:news_app/src/domain/model/articles.dart';
import 'package:riverpod/src/framework.dart';

abstract interface class IFavouriteArticlesRepository {
  IFavouriteArticlesRepository(Function<T>(ProviderListenable provider) read);

  Future<void> saveNewsArticles(List<NewsArticle> articles);
  Future<List<NewsArticle>> getNewsArticles();
  Future<void> toggleNewsArticle(NewsArticle article);
}
