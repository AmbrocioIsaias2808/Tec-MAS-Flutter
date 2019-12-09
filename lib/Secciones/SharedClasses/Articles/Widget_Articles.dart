import 'package:flutter/material.dart';
import 'package:tecmas/BarraDeNavegacion/Drawer.dart';
import 'package:tecmas/Temas/BaseTheme.dart';

import 'ArticlesList.dart';



class Widget_Articles extends StatelessWidget {

  final String URL;
  final String SeccionTitle;

  Widget_Articles({@required this.SeccionTitle,@required this.URL});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseThemeColor_DarkBlue,
      appBar: AppBar(
        title: Text(SeccionTitle),
        backgroundColor: BaseThemeAppBarColor,
      ),
      drawer: BarraDeNavegacion(),
      body: ArticlesList(URL:URL),
    );
  }
}
