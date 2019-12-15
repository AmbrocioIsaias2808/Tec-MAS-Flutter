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
  PageController pagecontroller = PageController();
  String title;
  var ActualPage; //Este valor incrementa o decrementa paulatinamiente al paginar en forma de un valor double. Por ejemplo: si estoy entre la pagina 1 y la pagina 2 el valor deberia dar algo como 1.5


  @override
  void initState() {
    super.initState();
    title=SeccionTitle;
    pagecontroller.addListener(() {
      setState(() {
        if(pagecontroller.page>=0.7){
          title="Articulos Guardados";
        }
        if(pagecontroller.page<0.7){
          title=SeccionTitle;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: BaseThemeColor_DarkBlue,
        appBar: AppBar(
          title: Text(title),
          backgroundColor: BaseThemeAppBarColor,
        ),
        drawer: BarraDeNavegacion(),
          body: PageView(
            controller: pagecontroller,
            children: <Widget>[
              ArticlesList(URL:URL, Category: Category),
              SavedArticles()
      ],
      ),
    );
      }

  @override
  bool get wantKeepAlive => true;
}