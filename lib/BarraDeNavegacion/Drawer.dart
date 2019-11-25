import "package:flutter/material.dart";

import 'Cabecera.dart';
import 'Seccion.dart';

class BarraDeNavegacion extends StatelessWidget {



  BarraDeNavegacion();

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

            Seccion(SectionIcon: Icons.home,SectionText: "Inicio",color:Colors.black,accion: (){Navigator.pushNamed(context, '/');},),
            Seccion(SectionIcon: Icons.account_balance,SectionText: "Becas",color:Colors.black,accion: (){Navigator.pushNamed(context, '/Becas');},),
            Seccion(SectionIcon: Icons.calendar_today,SectionText: "Calendario",color:Colors.black,accion:(){Navigator.pushNamed(context, '/Calendario');} ,),
            Seccion(SectionIcon: Icons.airport_shuttle,SectionText: "Transporte",color:Colors.black,accion:(){Navigator.pushNamed(context, '/Transporte');}),
            Seccion(SectionIcon: Icons.local_hospital,SectionText: "Emergencias",color:Colors.black,accion:(){Navigator.pushNamed(context, '/Emergencias');}),
            Seccion(SectionIcon: Icons.map,SectionText: "Mapa Interactivo",color:Colors.black,accion:(){Navigator.pushNamed(context, '/Mapa');}),
            // Seccion(SectionIcon: Icons.book,SectionText: "SII",color:Colors.black,accion: ()=> funcSeccionActual(7.0,context)),

          ],
        ),
      ),
    );
  }
}
