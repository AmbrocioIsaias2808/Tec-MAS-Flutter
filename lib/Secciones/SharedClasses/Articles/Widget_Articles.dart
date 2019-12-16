import 'package:flutter/material.dart';
import 'package:tecmas/BarraDeNavegacion/Drawer.dart';
import 'package:tecmas/Secciones/Calendario/Widget_Calendario.dart';
import 'package:tecmas/Secciones/SharedClasses/Articles/SavedArticles.dart';
import 'package:tecmas/Secciones/Transporte/Widget_Transporte.dart';
import 'package:tecmas/Temas/BaseTheme.dart';

import 'ArticlesList.dart';

class Widget_Articles extends StatefulWidget {

final String URL;
final String SeccionTitle;
final int Category;

Widget_Articles({@required this.SeccionTitle,@required this.URL, @required this.Category});

  @override
  _Widget_ArticlesState createState() => _Widget_ArticlesState(URL: URL, SeccionTitle: SeccionTitle, Category: Category);
}

class _Widget_ArticlesState extends State<Widget_Articles> with AutomaticKeepAliveClientMixin<Widget_Articles>{

  final String URL;
  final String SeccionTitle;
  final int Category;

  _Widget_ArticlesState({@required this.SeccionTitle,@required this.URL, @required this.Category});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: BaseThemeColor_DarkBlue,
        appBar: AppBar(
          title: Text(SeccionTitle),
          backgroundColor: BaseThemeAppBarColor,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.folder_special),
              onPressed: () {
                Navigator.pushNamed(context, '/Favoritos');
              },
            ),
          ],
        ),
        drawer: BarraDeNavegacion(),
          body: ArticlesList(URL:URL, Category: Category),
    );
      }

  @override
  bool get wantKeepAlive => true;
}