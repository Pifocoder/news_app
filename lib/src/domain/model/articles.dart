
class NewsArticle {
  final String sourceName;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final String content;

  NewsArticle({
    required this.sourceName,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      sourceName: json['source'] != null
          ? json['source']['name']
          : json['sourceName'] ?? "Unknown source",
      author: json['author'] ?? 'Unknown author',
      title: json['title'] ?? 'Untitled',
      description: json['description'] ?? 'No description available',
      url: json['url'] ?? 'No URL',
      urlToImage: json['urlToImage'] ?? 'No image available',
      publishedAt:
          DateTime.parse(json['publishedAt'] ?? DateTime.now().toString()),
      content: json['content'] ?? 'No content available',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'sourceName': sourceName,
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt.toIso8601String(),
      'content': content,
    };
  }
}

class NewsSource {
  final String id;
  final String name;

  NewsSource({
    required this.id,
    required this.name,
  });

  factory NewsSource.fromJson(Map<String, dynamic> json) {
    return NewsSource(
      id: json['id'] ?? 'Unknown ID',
      name: json['name'] ?? 'Unknown source',
    );
  }
}
