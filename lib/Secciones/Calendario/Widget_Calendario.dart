import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tecmas/BarraDeNavegacion/Drawer.dart';
import 'package:tecmas/Secciones/SharedClasses/CustomAppBar.dart';
import 'package:tecmas/Secciones/SharedClasses/LoadingWidget.dart';
import 'package:tecmas/Secciones/SharedClasses/PDFViewer.dart';
import 'package:path_provider/path_provider.dart';

class Widget_Calendario extends StatefulWidget {
  String url;
  Widget_Calendario({@required this.url});
  @override
  _Widget_CalendarioState createState() => _Widget_CalendarioState();
}

class _Widget_CalendarioState extends State<Widget_Calendario>  with AutomaticKeepAliveClientMixin<Widget_Calendario>{

  String pdfPath="";
  String pdfName="Documento";


  void getPdf()async{
    var dir = await getApplicationDocumentsDirectory();
    File file;
    FileCreator fileCreator = new FileCreator();
    if(FileSystemEntity.typeSync("${dir.path}/${pdfName}.pdf") != FileSystemEntityType.notFound){
      print("Lo Encontre: Cargando de memoria");

      setState(() {
        pdfPath="${dir.path}/${pdfName}.pdf";
      });
    }else{
      print("No lo encontre: Descargando");
      try{
        file= await fileCreator.createFileFromUrl(widget.url, pdfName, "pdf");
        setState(() {
          pdfPath=file.path;
        });
      }
      catch(e){
        print("Error generado en Widget: Calendario al cargar el archivo"+e.toString());
      }

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPdf();
  }

  void refresh(){
    try{
      final dir = Directory(pdfPath);
      dir.deleteSync(recursive: true);
    }catch(e){
      print("Already deleted: ");
    }
    setState(() {
      pdfPath="";
    });
    getPdf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BarraDeNavegacion(),
      appBar: CustomAppBar(title: "Calendario", actions: <Widget>[
        IconButton(icon: Icon(Icons.refresh),onPressed: (){
          refresh();
        },)
      ],),
      body: pdfPath=="" ? LoadingWidget() : pdfPath=="null" ? CircularProgressIndicator():PDFViewer(filepath: pdfPath, errorHandeler: (){refresh();},),
    );
  }
  @override
  bool get wantKeepAlive => true;
}
