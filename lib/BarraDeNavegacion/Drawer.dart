import "package:flutter/material.dart";
import 'package:tecmas/Secciones/SharedClasses/Messeges/AboutMessege.dart';

import '../main.dart';
import 'Cabecera.dart';
import 'Seccion.dart';

class BarraDeNavegacion extends StatelessWidget {



  BarraDeNavegacion();

  void ChangePage(dynamic context,int page){
    Navigator.pop(context);NavigateTo.jumpToPage(page);
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
            SizedBox(height: 5,),
            Seccion(SectionIcon: Icons.home,SectionText: "Inicio",iconColor:Colors.white,accion: (){ChangePage(context,0);},),
            Seccion(SectionIcon: Icons.calendar_today,SectionText: "Calendario",iconColor:Colors.white,accion:(){ChangePage(context,4);} ,),
            Seccion(SectionIcon: Icons.airport_shuttle,SectionText: "Transporte",iconColor:Colors.white,accion:(){ChangePage(context,5);}),
            Seccion(SectionIcon: Icons.map,SectionText: "Mapa Interactivo",iconColor:Colors.white,accion:(){ChangePage(context,6);}),
            Seccion(SectionIcon: Icons.book,SectionText: "SII",iconColor:Colors.white,accion: (){Scaffold.of(context).removeCurrentSnackBar();Navigator.pushNamed(context, '/SII');}),
            //Seccion(SectionIcon: Icons.book,SectionText: "pol",color:Colors.white,accion: (){Scaffold.of(context).removeCurrentSnackBar();Navigator.pushNamed(context, '/pol');}),
            Seccion(SectionIcon: Icons.info,SectionText: "More Info",iconColor:Colors.white,accion: (){AboutMessege(context);/*Navigator.pushNamed(context, "/pol");*/}),


          ],
        ),
      ),
    );
  }
}
