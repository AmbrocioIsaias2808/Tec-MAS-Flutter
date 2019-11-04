import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Widget_SII extends StatelessWidget {
/*
  @override
  Widget build(BuildContext context) {
    return Container(
      child: WebviewScaffold(
        url: 'http://mictlantecuhtli.itmatamoros.edu.mx',
        hidden: true,
        withZoom: true,
      )
    );
  }
*/

 final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WebView(
          initialUrl:'http://mictlantecuhtli.itmatamoros.edu.mx',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ),

      floatingActionButton: FutureBuilder<WebViewController>(
        future:_controller.future,
        builder: (BuildContext context, AsyncSnapshot<WebViewController> controller){
          if(controller.hasData){
            return FloatingActionButton(

              child: Icon(Icons.refresh),
              onPressed: (){
                  controller.data.reload();
              },
            );
          }
        }
      ),
    );
  }



}
