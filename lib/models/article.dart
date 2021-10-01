import 'package:flutter/foundation.dart';

class Article {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;

  Article(
      {this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt});

  factory Article.fromJson(Map<String, dynamic> jsonData) {
    return Article(
      title: jsonData['title'],
      description: jsonData['description'],
      url: jsonData['url'],
      urlToImage: jsonData['urlToImage'],
      publishedAt: jsonData['publishedAt']
    );
  }
}
