import 'package:flutter/material.dart';
import 'package:tecmas/BarraDeNavegacion/Drawer.dart';
import 'package:tecmas/Secciones/Calendario/Widget_Calendario.dart';
import 'package:tecmas/Secciones/SharedClasses/Articles/SavedArticles.dart';
import 'package:tecmas/Secciones/SharedClasses/CustomAppBar.dart';
import 'package:tecmas/Secciones/Transporte/Widget_Transporte.dart';
import 'package:tecmas/Temas/BaseTheme.dart';

import 'ArticlesList.dart';

class Widget_Articles extends StatefulWidget {

final String SeccionTitle;
final int Category;

Widget_Articles({@required this.SeccionTitle, @required this.Category});

  @override
  _Widget_ArticlesState createState() => _Widget_ArticlesState(SeccionTitle: SeccionTitle, Category: Category);
}

class _Widget_ArticlesState extends State<Widget_Articles> with AutomaticKeepAliveClientMixin<Widget_Articles>{

  final String SeccionTitle;
  final int Category;

  _Widget_ArticlesState({@required this.SeccionTitle, @required this.Category});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: CustomAppBar(title: SeccionTitle, actions: <Widget>[
        IconButton(
          icon: Icon(Icons.folder_special),
          onPressed: () {
            Scaffold.of(getArticlesListContext()).removeCurrentSnackBar();
            Navigator.pushNamed(context, '/Favoritos');
          },
        )
      ],
      ),
      extendBodyBehindAppBar: true,
      drawer: BarraDeNavegacion(),
      body: ArticlesList(Category: Category),
    );
      }

  @override
  bool get wantKeepAlive => true;
}