import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/screens/detail_screen.dart';
import 'package:news_app/view_models/articles_view_model.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final provider = Provider.of<ArticlesViewModel>(context, listen: false);
    provider.fetchAll();
    // provider.fetchArticles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ArticlesViewModel>(context);

    var pages = [
      Container(
        child: provider.technologyArticles.length > 0
            ? news(provider.technologyArticles)
            : Text('No News Found!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ),
      Container(
        child: provider.sportsArticles.length > 0
            ? news(provider.sportsArticles)
            : Text('No News Found!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ),
      Container(
        child: provider.healthArticles.length > 0
            ? news(provider.healthArticles)
            : Text('No News Found!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ),
      Container(
        child: provider.scienceArticles.length > 0
            ? news(provider.scienceArticles)
            : Text('No News Found!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ),
    ];

    SystemChrome.setEnabledSystemUIOverlays([]);
    //SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values)
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue, //or set color with: Color(0xFF0000FF)
    ));
    return MaterialApp(
      title: 'News Cloud',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 8),
                child: Text(
                  'Breaking News',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
              ),
              Container(
                height: 300,
                width: double.infinity,
                padding: EdgeInsets.all(8),
                child: provider.allArticles.length > 0
                    ? ListView(
                        scrollDirection: Axis.horizontal,
                        children: provider.allArticles.map((article) {
                          return buildContainer(
                            article.urlToImage,
                            article.title,
                            article.description,
                            article.url,
                            article.publishedAt,
                          );
                        }).toList(),
                      )
                    : Text('No News Found!'),
              ),
              DefaultTabController(
                length: 4, // length of tabs
                initialIndex: 0,
                child: Container(
                  child: TabBar(
                    onTap: (value) {
                      Provider.of<ArticlesViewModel>(context, listen: false)
                          .changeTabIndex(value);
                    },
                    isScrollable: true,
                    // labelPadding: EdgeInsets.zero,
                    labelColor: Colors.blueAccent,
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    unselectedLabelStyle:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
                    unselectedLabelColor: Colors.grey,
                    indicatorPadding: EdgeInsets.all(-0.5),
                    tabs: [
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          padding: EdgeInsets.zero,
                          child: Tab(text: 'Technology')),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          padding: EdgeInsets.zero,
                          child: Tab(text: 'Sports')),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          padding: EdgeInsets.zero,
                          child: Tab(text: 'Health')),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          padding: EdgeInsets.zero,
                          child: Tab(text: 'Science')),
                    ],
                  ),
                ),
              ),
              TabsView(
                  tabIndex: Provider.of<ArticlesViewModel>(context).tabIndex,
                  pages: pages)
            ]),
          ),
        ),
      ),
    );
  }

  Column news(List<Article> articleList) {
    return Column(
      children: articleList != null
          ? articleList
              .map((item) => buildRow(item.urlToImage, item.title,
                  item.description, item.url, item.publishedAt))
              .toList()
          : [],
    );
  }

  Widget buildContainer(String imageUrl, String title, String description,
      String articleUrl, String publishedAt) {
    return Builder(
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(
                imageUrl: imageUrl,
                title: title,
                description: description,
                articleUrl: articleUrl,
                publishedAt: publishedAt,
              ),
            ),
          ),
          child: Container(
            height: 300,
            width: 200,
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.blue),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Hero(
                    tag: title,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  height: 140,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                      child: Container(
                        height: 150,
                        width: 200,
                        color: Colors.black.withOpacity(0.4),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  title,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      height: 1.2,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.end,
                                  softWrap: true,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        dateToAgo(publishedAt),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}

String dateToAgo(String date) {
  return timeago.format(DateTime.parse(date));
}

Widget buildRow(String imageUrl, String title, String description,
    String articleUrl, String publishedAt) {
  return Builder(
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(
                imageUrl: imageUrl,
                title: title,
                description: description,
                articleUrl: articleUrl,
                publishedAt: publishedAt,
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Hero(
                  tag: title,
                  child: Image.network(
                    imageUrl,
                    width: 85,
                    height: 85,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: RichText(
                    textAlign: TextAlign.right,
                    text: TextSpan(
                      text: '$title\n',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          height: 1.1),
                      children: [
                        TextSpan(
                            text:
                                '${DateFormat('MMM d y   h:mm a').format(DateTime.parse(publishedAt))}',
                            style: TextStyle(
                                fontWeight: FontWeight.normal, height: 2))
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

class TabsView extends StatelessWidget {
  TabsView({Key key, @required this.tabIndex, @required this.pages})
      : super(key: key);

  final int tabIndex;
  final List<Widget> pages;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ...pages.map((page) {
          return AnimatedContainer(
            child: FutureBuilder(
                future: Future.delayed(Duration(milliseconds: 500)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return page;
                  } else {
                    return Visibility(
                        visible: tabIndex == pages.indexOf(page) ? true : false,
                        child: page);
                  }
                }),
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            transform: Matrix4.translationValues(
                tabIndex == pages.indexOf(page)
                    ? 0
                    : tabIndex > pages.indexOf(page)
                        ? (pages.indexOf(page) -
                            tabIndex) *
                                MediaQuery.of(context).size.width
                        : (pages.indexOf(page) -
                           tabIndex ) *
                                MediaQuery.of(context).size.width,
                0,
                0

                /*
                tabIndex == pages.indexOf(page)
                    ? 0
                    : tabIndex > pages.indexOf(page)
                        ? -MediaQuery.of(context).size.width
                        : MediaQuery.of(context).size.width,
                0,
                0,
               */
                ),
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
        }).toList()
      ],
    );
  }
}
