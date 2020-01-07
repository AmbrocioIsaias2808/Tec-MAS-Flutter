import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:numberpicker/numberpicker.dart';
import 'package:tecmas/Secciones/SharedClasses/LoadingWidget.dart';
import 'package:tecmas/Secciones/SharedClasses/Messeges/BasicMSGDialog.dart';


//Basado en :https://www.youtube.com/watch?v=5S9qjreGFNc
class FileCreator{

  Future<File> createFileFromAsset(String asset, String fileName, String ext) async {
    print("Entre aqui");
    try {
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/${fileName}.${ext}");

      File assetFile = await file.writeAsBytes(bytes);
      return assetFile;
    } catch (e) {
      throw Exception("Error opening asset file");
    }
  }

  Future<File> createFileFromUrl(String url, String fileName, String ext) async {
    print("Creando archivo desde internet");
    try {
      var data = await http.get(url);
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/${fileName}.${ext}");

      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }

}

class PDFViewer extends StatefulWidget {

  final String filepath;
  final Function errorHandeler;
  const PDFViewer({Key key, this.filepath, this.errorHandeler}) : super(key: key);


  @override
  _PDFViewerState createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  PDFViewController _pdfViewController;
  bool error=false;

  void _pickPageDialog(int currentPage, int totalPages) {
    if(pdfReady==true){
      showDialog<int>(
          context: context,
          builder: (BuildContext context) {
            return new NumberPickerDialog.integer(
              minValue: 1,
              maxValue: totalPages,
              title: new Text("Selecciona la página:"),
              initialIntegerValue:currentPage+1,
            );
          }
      ).then((int value) {
        if (value != null) {
          setState(() => _pdfViewController.setPage(value-1));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: error?
          BasicMSGDialog(MessegeType: 1,Title:"Error al cargar documento",Description: "Comprueba tu conexión e intenta de nuevo",ButtonText: "¿Reintentar?",ButtonTextColor: Colors.white,ButtonAction: widget.errorHandeler,)
          :Stack(
        children: <Widget>[
          Container(
              child: PDFView(
                filePath: widget.filepath,
                autoSpacing: true,
                enableSwipe: true,
                pageSnap: true,
                swipeHorizontal: true,
                nightMode: false,
                onError: (e) {
                  setState(() {
                    error=true;
                  });
                  print("Error en lector pdf:"+e.toString());
                },
                onRender: (_pages) {
                  setState(() {
                    _totalPages = _pages;
                    pdfReady = true;
                  });
                },
                onViewCreated: (PDFViewController vc) {
                  _pdfViewController = vc;
                },
                onPageChanged: (int page, int total) {
                  setState(() {_currentPage=page;});
                },
                onPageError: (page, e) {setState(() {
                  error=true;
                });},
              )),
          pdfReady==false? LoadingWidget(): Offstage()
        ],
      ),
      floatingActionButton: FloatingActionButton(heroTag: UniqueKey(),child: Icon(Icons.view_carousel), onPressed: (){_pickPageDialog(_currentPage, _totalPages);},),
      bottomNavigationBar: PDFNavigationBar(totalPages: _totalPages,currentPage: _currentPage,pdfViewController: _pdfViewController, blockaction: !pdfReady,) ,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }
}


class PDFNavigationBar extends StatelessWidget {

  int totalPages;
  int currentPage;
  bool blockaction;
  PDFViewController pdfViewController;

  PDFNavigationBar({this.totalPages, this.currentPage,this.pdfViewController, this.blockaction=false});

  @override
  Widget build(BuildContext context) {
    return Container(color:Colors.white,child: Row(
      children: <Widget>[
        PDFNCommandButton(Icono: Icon(Icons.first_page),onPressed: blockaction==false? (){
          pdfViewController.setPage(0);
        }:(){},iconSize: 30,),

        PDFNCommandButton(Icono: Icon(Icons.arrow_back_ios),onPressed: blockaction==false? (){
          if(currentPage>0){
            currentPage=currentPage-1;
            pdfViewController.setPage(currentPage);
          }
        }:(){},),
        PDFNCommandButton(Icono: Icon(Icons.arrow_forward_ios),onPressed: blockaction==false?(){
          if(currentPage+1<totalPages){
            currentPage=currentPage+1;
            pdfViewController.setPage(currentPage);
          }
        }:(){}),

        PDFNCommandButton(Icono: Icon(Icons.last_page),onPressed: blockaction==false?(){
          pdfViewController.setPage(totalPages);
        }:(){},iconSize: 30,),
      ],
    ),);
  }
}


class PDFNCommandButton extends StatelessWidget {
  Function onPressed;
  Icon Icono;
  double iconSize;
  PDFNCommandButton({this.onPressed=null, this.Icono, this.iconSize=20.0});
  @override
  Widget build(BuildContext context) {
    return Expanded(child: IconButton(icon:Icono, iconSize: iconSize,
      onPressed: onPressed
    ),);
  }
}
