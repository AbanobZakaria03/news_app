import 'package:flutter/material.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/services/news_service.dart';

class ArticlesViewModel extends ChangeNotifier {
  List<Article> _allArticles = [];
  List<Article> _technologyArticles = [];
  List<Article> _sportsArticles = [];
  List<Article> _healthArticles = [];
  List<Article> _scienceArticles = [];
  int prevTabIndex = 0;
  int tabIndex = 0;

  List<Article> get allArticles {
    return _allArticles.where((article) => article.urlToImage != null).toList();
  }

  List<Article> get technologyArticles {
    return _technologyArticles
        .where((article) =>
            article.urlToImage != null &&
            !article.urlToImage.contains('www.aljazeera.net'))
        .toList();
  }

  List<Article> get sportsArticles {
    return _sportsArticles
        .where((article) =>
            article.urlToImage != null &&
            !article.urlToImage.contains('www.aljazeera.net'))
        .toList();
  }

  List<Article> get healthArticles {
    return _healthArticles
        .where((article) =>
            article.urlToImage != null &&
            !article.urlToImage.contains('www.aljazeera.net'))
        .toList();
  }

  List<Article> get scienceArticles {
    return _scienceArticles
        .where((article) =>
            article.urlToImage != null &&
            !article.urlToImage.contains('www.aljazeera.net'))
        .toList();
  }

  fetchArticles() async {
    _allArticles = await NewsApi().fetchAllArticles();
    notifyListeners();
  }

  fetchTechnologyArticles() async {
    _technologyArticles = await NewsApi().fetchTechnologyArticles();
    notifyListeners();
  }

  fetchSportsArticles() async {
    _sportsArticles = await NewsApi().fetchSportsArticles();
    notifyListeners();
  }

  fetchHealthArticles() async {
    _healthArticles = await NewsApi().fetchHealthArticles();
    notifyListeners();
  }

  fetchScienceArticles() async {
    _scienceArticles = await NewsApi().fetchScienceArticles();
    notifyListeners();
  }

  fetchAll() async {
    await fetchArticles();
    await fetchTechnologyArticles();
    await fetchSportsArticles();
    await fetchHealthArticles();
    await fetchScienceArticles();
  }

  changeTabIndex(index) {
    prevTabIndex = tabIndex;
    tabIndex = index;
    notifyListeners();
  }
}
