import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:tecmas/BarraDeNavegacion/Drawer.dart';
import 'package:tecmas/Secciones/SharedClasses/Messeges/CustomWebview.dart';
import 'package:tecmas/Temas/BaseTheme.dart';
import 'dart:convert';
import 'package:flutter_user_agent/flutter_user_agent.dart';
//import 'package:webview_flutter/webview_flutter.dart';

import '../CommonlyUsed.dart';
import '../LoadingWidget.dart';



class ArticleViewer extends StatelessWidget {

  final String ArticleContent;
  final String title;


  String filePath='assets/ArticleViewer/base.html';

  ArticleViewer({@required this.ArticleContent, @required this.title});

  @override
  Widget build(BuildContext context) {
    return CustomWebview(CombineFileAndHTMLBODY: true, HTMLString:ArticleContent , PATH_FROMLOCALFILE: filePath, title: title,);
  }
}
