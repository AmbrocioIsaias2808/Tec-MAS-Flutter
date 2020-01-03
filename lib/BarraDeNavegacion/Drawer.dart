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
      foregroundDecoration: BoxDecoration(shape: BoxShape.circle),
      width: 260,
      child:Drawer(

        child: ListView(
          padding: const EdgeInsets.all(0.0),
          children: <Widget>[
            Cabecera(),

            SafeArea(child: Container(child:Column(children: <Widget>[
              Seccion(SectionIcon: Icons.home,SectionText: "Inicio",iconColor:Colors.white,accion: (){ChangePage(context,0);},),
              Seccion(SectionIcon: Icons.account_balance,SectionText: "Becas",iconColor:Colors.white,accion: (){ChangePage(context,1);},),
              Seccion(SectionIcon: Icons.calendar_today,SectionText: "Calendario",iconColor:Colors.white,accion:(){ChangePage(context,2);} ,),
              Seccion(SectionIcon: Icons.airport_shuttle,SectionText: "Transporte",iconColor:Colors.white,accion:(){ChangePage(context,3);}),
              Seccion(SectionIcon: Icons.local_hospital,SectionText: "Emergencias",iconColor:Colors.white,accion:(){ChangePage(context,4);}),
              Seccion(SectionIcon: Icons.map,SectionText: "Mapa Interactivo",iconColor:Colors.white,accion:(){ChangePage(context,5);}),
              Seccion(SectionIcon: Icons.book,SectionText: "SII",iconColor:Colors.white,accion: (){Scaffold.of(context).removeCurrentSnackBar();Navigator.pushNamed(context, '/SII');}),
              //Seccion(SectionIcon: Icons.book,SectionText: "pol",color:Colors.white,accion: (){Scaffold.of(context).removeCurrentSnackBar();Navigator.pushNamed(context, '/pol');}),
              Seccion(SectionIcon: Icons.info,SectionText: "More Info",iconColor:Colors.white,accion: (){_showDialog(context);/*Navigator.pushNamed(context, "/pol");*/}),
            ],),),)

          ],
        ),
      ),
    );
  }
}
