import "package:flutter/material.dart";
import 'package:tecmas/Secciones/SharedClasses/Messeges/AboutMessege.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_appavailability/flutter_appavailability.dart';

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
            Seccion(SectionIcon: Icons.account_balance,SectionText: "Becas",iconColor:Colors.white,accion: (){ChangePage(context,1);},),
            Seccion(SectionIcon: Icons.calendar_today,SectionText: "Calendario",iconColor:Colors.white,accion:(){ChangePage(context,4);} ,),
            Seccion(SectionIcon: Icons.airport_shuttle,SectionText: "Transporte",iconColor:Colors.white,accion:(){ChangePage(context,5);}),
            Seccion(SectionIcon: Icons.local_hospital,SectionText: "Emergencias",iconColor:Colors.white,accion:(){ChangePage(context,2);}),
            Seccion(SectionIcon: Icons.assignment_turned_in,SectionText: "Recursos Académicos",iconColor:Colors.white,accion:(){AppCaller();}/*(){ChangePage(context,6);}*/),
            Seccion(SectionIcon: Icons.book,SectionText: "SII",iconColor:Colors.white,accion: (){Scaffold.of(context).removeCurrentSnackBar();Navigator.pushNamed(context, '/SII');}),
            //Seccion(SectionIcon: Icons.book,SectionText: "pol",color:Colors.white,accion: (){Scaffold.of(context).removeCurrentSnackBar();Navigator.pushNamed(context, '/pol');}),
            Seccion(SectionIcon: Icons.info,SectionText: "More Info",iconColor:Colors.white,accion: (){AboutMessege(context);/*Navigator.pushNamed(context, "/pol");*/}),


          ],
        ),
      ),
    );
  }
}


void AppCaller()async{

  AppAvailability.launchApp("com.RechargerPlay.Chemistry").then((_) {
  }).catchError((err) {
    print(err);
  });
  }