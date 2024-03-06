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
      sourceName:
          json['source'] != null ? json['source']['name'] : 'Unknown source',
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

// Testing examples
List<Map<String, dynamic>> sampleArticles = [
  {
    "source": {"id": null, "name": "Biztoc.com"},
    "author": "mediaite.com",
    "title":
        "Elon Musk Pushes Wild Theory Democrats Are ‘Deliberately Importing Vast Numbers of Illegals’ to Win Elections",
    "description":
        "Elon Musk, the controversial billionaire owner of X, slammed the Biden administration in the early hours of Tuesday morning and pushed the so-called “great replacement” conspiracy theory, which has been linked to mass shootings in the U.S. Musk made the comme…",
    "url": "https://biztoc.com/x/c3098994c9a3ed35",
    "urlToImage": "https://c.biztoc.com/p/c3098994c9a3ed35/s.webp",
    "publishedAt": "2024-03-04T17:42:13Z",
    "content":
        "Elon Musk, the controversial billionaire owner of X, slammed the Biden administration in the early hours of Tuesday morning and pushed the so-called great replacement conspiracy theory, which has bee… [+279 chars]"
  },
  {
    "source": {"id": null, "name": "CNN"},
    "author": "CNN",
    "title": "Sample Title 2",
    "description": "Sample Description 2",
    "url": "https://www.example.com/sample-article-2",
    "urlToImage": "https://www.example.com/sample-image-2.jpg",
    "publishedAt": "2024-03-04T12:00:00Z",
    "content": "Sample Content 2"
  },
  {
    "source": {"id": null, "name": "BBC News"},
    "author": "BBC",
    "title": "Sample Title 3",
    "description": "Sample Description 3",
    "url": "https://www.example.com/sample-article-3",
    "urlToImage": "https://www.example.com/sample-image-3.jpg",
    "publishedAt": "2024-03-03T12:00:00Z",
    "content": "Sample Content 3"
  },
  {
    "source": {"id": null, "name": "Biztoc.com"},
    "author": "mediaite.com",
    "title":
        "Elon Musk Pushes Wild Theory Democrats Are ‘Deliberately Importing Vast Numbers of Illegals’ to Win Elections",
    "description":
        "Elon Musk, the controversial billionaire owner of X, slammed the Biden administration in the early hours of Tuesday morning and pushed the so-called “great replacement” conspiracy theory, which has been linked to mass shootings in the U.S. Musk made the comme…",
    "url": "https://biztoc.com/x/c3098994c9a3ed35",
    "urlToImage": "https://c.biztoc.com/p/c3098994c9a3ed35/s.webp",
    "publishedAt": "2024-03-05T17:42:13Z",
    "content":
        "Elon Musk, the controversial billionaire owner of X, slammed the Biden administration in the early hours of Tuesday morning and pushed the so-called great replacement conspiracy theory, which has bee… [+279 chars]"
  },
  {
    "source": {"id": null, "name": "CNN"},
    "author": "CNN",
    "title": "Sample Title 2",
    "description": "Sample Description 2",
    "url": "https://www.example.com/sample-article-2",
    "urlToImage": "https://www.example.com/sample-image-2.jpg",
    "publishedAt": "2024-03-04T12:00:00Z",
    "content": "Sample Content 2"
  },
  {
    "source": {"id": null, "name": "BBC News"},
    "author": "BBC",
    "title": "Sample Title 3",
    "description": "Sample Description 3",
    "url": "https://www.example.com/sample-article-3",
    "urlToImage": "https://www.example.com/sample-image-3.jpg",
    "publishedAt": "2024-03-03T12:00:00Z",
    "content": "Sample Content 3"
  },
  {
    "source": {"id": null, "name": "Biztoc.com"},
    "author": "mediaite.com",
    "title":
        "Elon Musk Pushes Wild Theory Democrats Are ‘Deliberately Importing Vast Numbers of Illegals’ to Win Elections",
    "description":
        "Elon Musk, the controversial billionaire owner of X, slammed the Biden administration in the early hours of Tuesday morning and pushed the so-called “great replacement” conspiracy theory, which has been linked to mass shootings in the U.S. Musk made the comme…",
    "url": "https://biztoc.com/x/c3098994c9a3ed35",
    "urlToImage": "https://c.biztoc.com/p/c3098994c9a3ed35/s.webp",
    "publishedAt": "2024-03-05T17:42:13Z",
    "content":
        "Elon Musk, the controversial billionaire owner of X, slammed the Biden administration in the early hours of Tuesday morning and pushed the so-called great replacement conspiracy theory, which has bee… [+279 chars]"
  },
  {
    "source": {"id": null, "name": "CNN"},
    "author": "CNN",
    "title": "Sample Title 2",
    "description": "Sample Description 2",
    "url": "https://www.example.com/sample-article-2",
    "urlToImage": "https://www.example.com/sample-image-2.jpg",
    "publishedAt": "2024-03-04T12:00:00Z",
    "content": "Sample Content 2"
  },
  {
    "source": {"id": null, "name": "BBC News"},
    "author": "BBC",
    "title": "Sample Title 3",
    "description": "Sample Description 3",
    "url": "https://www.example.com/sample-article-3",
    "urlToImage": "https://www.example.com/sample-image-3.jpg",
    "publishedAt": "2024-03-03T12:00:00Z",
    "content": "Sample Content 3"
  },
  {
    "source": {"id": null, "name": "Biztoc.com"},
    "author": "mediaite.com",
    "title":
        "Elon Musk Pushes Wild Theory Democrats Are ‘Deliberately Importing Vast Numbers of Illegals’ to Win Elections",
    "description":
        "Elon Musk, the controversial billionaire owner of X, slammed the Biden administration in the early hours of Tuesday morning and pushed the so-called “great replacement” conspiracy theory, which has been linked to mass shootings in the U.S. Musk made the comme…",
    "url": "https://biztoc.com/x/c3098994c9a3ed35",
    "urlToImage": "https://c.biztoc.com/p/c3098994c9a3ed35/s.webp",
    "publishedAt": "2024-03-05T17:42:13Z",
    "content":
        "Elon Musk, the controversial billionaire owner of X, slammed the Biden administration in the early hours of Tuesday morning and pushed the so-called great replacement conspiracy theory, which has bee… [+279 chars]"
  },
  {
    "source": {"id": null, "name": "CNN"},
    "author": "CNN",
    "title": "Sample Title 2",
    "description": "Sample Description 2",
    "url": "https://www.example.com/sample-article-2",
    "urlToImage": "https://www.example.com/sample-image-2.jpg",
    "publishedAt": "2024-03-04T12:00:00Z",
    "content": "Sample Content 2"
  },
  {
    "source": {"id": null, "name": "BBC News"},
    "author": "BBC",
    "title": "Sample Title 3",
    "description": "Sample Description 3",
    "url": "https://www.example.com/sample-article-3",
    "urlToImage": "https://www.example.com/sample-image-3.jpg",
    "publishedAt": "2024-03-03T12:00:00Z",
    "content": "Sample Content 3"
  },
];

List<NewsArticle> articles =
    sampleArticles.map((json) => NewsArticle.fromJson(json)).toList();
