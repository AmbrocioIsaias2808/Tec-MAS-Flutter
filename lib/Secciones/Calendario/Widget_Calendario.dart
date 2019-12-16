import 'package:flutter/material.dart';

import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:tecmas/BarraDeNavegacion/Drawer.dart';
import 'package:tecmas/Temas/BaseTheme.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';


class Widget_Calendario extends StatefulWidget {
  String URL;
  String fromAsset;


  Widget_Calendario({@required this.URL=''});

  @override
  _Widget_CalendarioState createState() => _Widget_CalendarioState(fromURL: URL);

}

class _Widget_CalendarioState extends State<Widget_Calendario> with AutomaticKeepAliveClientMixin<Widget_Calendario>{


  bool _isLoading=true;
  PDFDocument Document;

  String fromURL;
  String fromAsset;


  _Widget_CalendarioState({this.fromURL='', this.fromAsset=''});

  void loadDocument() async{





    if(fromURL!=''){
      try{
        Document= await PDFDocument.fromURL(fromURL);
      }catch(e){

      }

    }else{
      Document= await PDFDocument.fromAsset(fromAsset);
    }

    setState(() {
      _isLoading=false;
    });





  }

  @override
  void initState() {

    super.initState();
    loadDocument();
  }

  bool networkerror=false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      drawer: BarraDeNavegacion(),
      appBar: AppBar(
        title: Text("Calendario Escolar"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: (){
              DefaultCacheManager().removeFile(fromURL);
              Future.delayed(Duration(milliseconds: 100),(){
                setState(() {
                  _isLoading=true;
                });
                loadDocument();
              }
              );
            },
          )
        ],
      ),
      body: Center(
          child:
            _isLoading ? Center(child: CircularProgressIndicator())
                : PDFViewer(document: Document, showPicker: true, showIndicator: true, showNavigation: true,indicatorBackground: BaseThemeColor_DarkBlue,),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}


