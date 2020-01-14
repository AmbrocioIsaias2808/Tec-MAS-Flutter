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
import 'dart:convert';
import 'dart:io';
import 'package:tecmas/Secciones/Estructures/Databases/DBHelper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tecmas/Secciones/Estructures/Articles.dart';
import '../../main.dart';


 dynamic ShowSnackWithDelay(dynamic context, int delay, Widget snack){
   return Future.delayed(Duration(milliseconds: delay),(){
     Scaffold.of(context).removeCurrentSnackBar();
     Scaffold.of(context).showSnackBar(snack);
   });
 }

Widget BasicSnack(String MSG){
  return SnackBar(content: Text(MSG,textAlign: TextAlign.justify));
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


Future<int> fetchInitData (int Categoria)async{

  try {
    //Base URL format: https://wordpresspruebas210919.000webhostapp.com/wp-json/wp/v2/posts?categories=CATEGORY&per_page=5&page=Pagina

    Future.delayed(Duration(milliseconds: 15000),()async{
      return 0;
    });

    final response = await http.get(serverSettings.PaginarPorCategoria(cantidadAMostrar: "5", NumDePagina: "1", categoriaAFiltrar: Categoria.toString()),
        headers:{
          'Authorization':'Bearer '+serverSettings.getApiKey(),
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }

    ).timeout(Duration(seconds: 15), onTimeout: (){
      Future.delayed(Duration(milliseconds: 0),()async{
        return 0;
      });
    });

    //print(response.headers);



    return Future.delayed(Duration(milliseconds: 5),()async{
      print("Response: "+response.statusCode.toString());
      if (response.statusCode == 200) {

        var DB = DBHelper();
        var jsonData=json.decode(response.body);
        var object;
        await DB.deleteAllByCategory(Categoria);// por ahora
        for(object in jsonData){

          String image;
          try{
            image=object['better_featured_image']['source_url'];
          }
          catch(error){
            image="https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRBZNpdaxzwE4Tehk16HHWNFRSxwXzKjhptSz-JrSwkIGD2QO68";
          }

          Articles a = Articles(
            ID:int.parse(Categoria.toString()+object["id"].toString()),
            num: object['id'],
            title:object['title']['rendered'],
            image: image,
            content: object['content']['rendered'],
            category: Categoria,
          );
           try {
             await DB.insert(a);
            }on Exception catch(e){
             print("Excepcion bD");
                return 0;
            }catch(e){
             print("Error BD");
                return 0;
            }


      }
        return 1;
      } else {
      // If that call was not successful, throw an error.
      if(response.statusCode==401){
      print("401 code run");
      return 0;
      return null;
      }
      throw Exception("Error");
      }
    });





  } on NoSuchMethodError catch(e){
    print("Error: "+e.toString());
    return 0;

  }on Exception catch(e) {
    print("Excepcion: "+e.toString());
    return 0;
  }catch(e){
    return 0;
  }

}
