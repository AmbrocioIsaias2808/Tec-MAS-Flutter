/*Este archivo fue creado apartir de la versión: TecMAS-19.12.11-(SQLiteDatabase) por Ambrocio Isaias Laureano Castro
*
* Este archivo ha sido pensado para almacenar funciones comunmiente usadas en los diferentes archivos, clases y secciones
* de código donde resulten utiles. Es de vital importancia recalcar que se debe tener especial cuidado en la modificación
* de estas lineas de código, cualquier cambio no planeado a detalle puede generar comportamientos inesperados y bugs
* no previstos por el programador.
*
* En resumen: Si no posees conocimientos necesarios y/o no sabes que realizan tales funciones !NO TOCAR¡
*
* */
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tecmas/Temas/BaseTheme.dart';


 dynamic ShowSnackWithDelay(dynamic context, int delay, Widget snack){
   return Future.delayed(Duration(milliseconds: 500),(){
     Scaffold.of(context).removeCurrentSnackBar();
     Scaffold.of(context).showSnackBar(snack);
     //print("Feature disable or network connection error");
   });
 }

Widget BasicSnack(String MSG){
  return SnackBar(content: Text(MSG,textAlign: TextAlign.justify,));
}

Future NetworkConnectionCkeck() async{
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return 1;
    }
  } on SocketException catch (_) {
    return 0;
  }
}