import 'dart:convert';

import 'package:news_app/models/article.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/articles.dart';

class NewsApi {
  final String apiKey = 'e432b1bf815e4139a3dae6e7c96c6550';

  Future<List<Article>> fetchAllArticles() async {
    try {
      http.Response response = await http.get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=eg&apiKey=$apiKey'));

      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        Articles articles = Articles.fromJson(jsonData);
        List<Article> articleList = articles.articles
            .map((article) => Article.fromJson(article))
            .toList();
        return articleList;
      } else {
        print(response.statusCode);
        return [];
      }
    } catch (ex) {
      print(ex);
      return [];
    }
  }

  Future<List<Article>> fetchTechnologyArticles() async {
    try {
      http.Response response = await http.get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=eg&category=technology&apiKey=$apiKey'));

      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        Articles articles = Articles.fromJson(jsonData);
        List<Article> articleList = articles.articles
            .map((article) => Article.fromJson(article))
            .toList();

        return articleList;
      } else {
        print(response.statusCode);
        return [];
      }
    } catch (ex) {
      print(ex);
      return [];
    }
  }

  Future<List<Article>> fetchSportsArticles() async {
    try {
      http.Response response = await http.get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=eg&category=sports&apiKey=$apiKey'));

      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        Articles articles = Articles.fromJson(jsonData);
        List<Article> articleList = articles.articles
            .map((article) => Article.fromJson(article))
            .toList();

        return articleList;
      } else {
        print(response.statusCode);
        return [];
      }
    } catch (ex) {
      print(ex);
      return [];
    }
  }

  Future<List<Article>> fetchHealthArticles() async {
    try {
      http.Response response = await http.get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=eg&category=health&apiKey=$apiKey'));

      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        Articles articles = Articles.fromJson(jsonData);
        List<Article> articleList = articles.articles
            .map((article) => Article.fromJson(article))
            .toList();

        return articleList;
      } else {
        print(response.statusCode);
        return [];
      }
    } catch (ex) {
      print(ex);
      return [];
    }
  }

  Future<List<Article>> fetchScienceArticles() async {
    try {
      http.Response response = await http.get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=eg&category=science&apiKey=$apiKey'));

      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        Articles articles = Articles.fromJson(jsonData);
        List<Article> articleList = articles.articles
            .map((article) => Article.fromJson(article))
            .toList();

        return articleList;
      } else {
        print(response.statusCode);
        return [];
      }
    } catch (ex) {
      print(ex);
      return [];
    }
  }
}
