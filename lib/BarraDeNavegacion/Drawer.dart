import "package:flutter/material.dart";

import '../main.dart';
import 'Cabecera.dart';
import 'Seccion.dart';

class BarraDeNavegacion extends StatelessWidget {



  BarraDeNavegacion();

  void ChangePage(dynamic context,int page){
    Navigator.pop(context);NavigateTo.jumpToPage(page);
  }

  void _showDialog(dynamic context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Version: 19.12.19"),
          content: new Text("Developer: Ambrocio Isaías Laureano Castro"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      child:Drawer(

        child: ListView(
          padding: const EdgeInsets.all(0.0),
          children: <Widget>[
            Container(
              height: 200,
              child: Cabecera(),
            ),

            Seccion(SectionIcon: Icons.home,SectionText: "Inicio",color:Colors.black,accion: (){ChangePage(context,0);},),
            Seccion(SectionIcon: Icons.account_balance,SectionText: "Becas",color:Colors.black,accion: (){ChangePage(context,1);},),
            Seccion(SectionIcon: Icons.calendar_today,SectionText: "Calendario",color:Colors.black,accion:(){ChangePage(context,2);} ,),
            Seccion(SectionIcon: Icons.airport_shuttle,SectionText: "Transporte",color:Colors.black,accion:(){ChangePage(context,3);}),
            Seccion(SectionIcon: Icons.local_hospital,SectionText: "Emergencias",color:Colors.black,accion:(){ChangePage(context,4);}),
            Seccion(SectionIcon: Icons.map,SectionText: "Mapa Interactivo",color:Colors.black,accion:(){ChangePage(context,5);}),
            Seccion(SectionIcon: Icons.book,SectionText: "SII",color:Colors.black,accion: (){Scaffold.of(context).removeCurrentSnackBar();Navigator.pushNamed(context, '/SII');}),
            //Seccion(SectionIcon: Icons.book,SectionText: "pol",color:Colors.black,accion: (){Scaffold.of(context).removeCurrentSnackBar();Navigator.pushNamed(context, '/pol');}),
            Seccion(SectionIcon: Icons.info,SectionText: "More Info",color:Colors.black,accion: (){_showDialog(context);}),

          ],
        ),
      ),
    );
  }
}
