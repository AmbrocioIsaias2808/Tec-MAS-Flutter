import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:tecmas/BarraDeNavegacion/Drawer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Widget_Calendario extends StatelessWidget {

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendario Escolar'),
      ),
      drawer: BarraDeNavegacion(),
      body:Container(
          child: WebView(
            initialUrl:'https://docs.google.com/gview?embedded=true&url=http://www.itmatamoros.edu.mx/wp-content/themes/tecnologico/pdf/Calendario_agosto_diciembre_2019',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);

            },
          ))
    );



  }


}


