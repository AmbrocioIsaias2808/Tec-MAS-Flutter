import "package:flutter/material.dart";
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:tecmas/Secciones/SharedClasses/Messeges/BasicMSGDialog.dart';

class pol extends StatefulWidget {
  @override
  _polState createState() => _polState();
}

class _polState extends State<pol> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BasicMSGDialog(Title: "Hola Mundo",Description: "hola mundo 2", ButtonAction: (){print("Holis");},ButtonColor: Colors.red, ButtonText: "Reintentar", MessegeType: 1,),
    );
  }
}
