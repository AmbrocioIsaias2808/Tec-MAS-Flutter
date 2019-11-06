import "package:flutter/material.dart";

import 'Cabecera.dart';
import 'Seccion.dart';

class BarraDeNavegacion extends StatelessWidget {

  final Function funcSeccionActual;  //Puntero a Funcion de estado

  BarraDeNavegacion({@required this.funcSeccionActual});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      child:Drawer(

        child: ListView(
          padding: const EdgeInsets.all(0.0),
          children: <Widget>[
            Container(
              height: 195,
              child: Cabecera(),
            ),

            Seccion(SectionIcon: Icons.home,SectionText: "Inicio",color:Colors.black,accion:()=> funcSeccionActual(1.0,context),),
            Seccion(SectionIcon: Icons.account_balance,SectionText: "Becas",color:Colors.black,accion: ()=> funcSeccionActual(2.0,context),),
            Seccion(SectionIcon: Icons.calendar_today,SectionText: "Calendario",color:Colors.black,accion: ()=> funcSeccionActual(3.0,context)),
            Seccion(SectionIcon: Icons.airport_shuttle,SectionText: "Transporte",color:Colors.black,accion: ()=> funcSeccionActual(4.0,context)),
            Seccion(SectionIcon: Icons.local_hospital,SectionText: "Emergencias",color:Colors.black,accion: ()=> funcSeccionActual(5.0,context)),
            Seccion(SectionIcon: Icons.map,SectionText: "Mapa Interactivo",color:Colors.black,accion: ()=> funcSeccionActual(6.0,context)),
            Seccion(SectionIcon: Icons.book,SectionText: "SII",color:Colors.black,accion: ()=> funcSeccionActual(7.0,context)),

          ],
        ),
      ),
    );
  }
}
