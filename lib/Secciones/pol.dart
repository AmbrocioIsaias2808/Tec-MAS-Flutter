import 'dart:io';

import "package:flutter/material.dart";
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:tecmas/Secciones/SharedClasses/CustomAppBar.dart';
import 'package:tecmas/Secciones/SharedClasses/LoadingWidget.dart';
import 'package:tecmas/Secciones/SharedClasses/Messeges/BasicMSGDialog.dart';
import 'package:tecmas/Secciones/SharedClasses/PDFViewer.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class pol extends StatefulWidget {
  @override
  _polState createState() => _polState();
}

class _polState extends State<pol> {

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
        file= await fileCreator.createFileFromUrl("http://www.itmatamoros.edu.mx/wp-content/themes/tecnologico/pdf/Calendario_agosto_diciembre_2019.pdf", pdfName, "pdf");
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
      appBar: CustomAppBar(title: "Calendario Pruebas", actions: <Widget>[
        IconButton(icon: Icon(Icons.refresh),onPressed: (){
          refresh();
        },)
      ],),
      body: pdfPath=="" ? LoadingWidget() : pdfPath=="null" ? CircularProgressIndicator(): PDFViewer(filepath: pdfPath, errorHandeler: (){refresh();},),
    );
  }
}


