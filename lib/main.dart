import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/screens/detail_screen.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/services/news_service.dart';
import 'package:news_app/test.dart';
import 'package:news_app/view_models/articles_view_model.dart';
import 'package:provider/provider.dart';

import 'models/article.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.bottom, SystemUiOverlay.top]);

  runApp(ChangeNotifierProvider(
    create: (BuildContext context) => ArticlesViewModel(),
    child: HomePage(),
  ));
}