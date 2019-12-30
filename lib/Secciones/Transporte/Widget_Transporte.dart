import 'package:flutter/material.dart';
import 'package:tecmas/BarraDeNavegacion/Drawer.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:tecmas/Secciones/SharedClasses/CommonlyUsed.dart';
import 'package:tecmas/Secciones/SharedClasses/CustomAppBar.dart';
import 'package:tecmas/Secciones/SharedClasses/LoadingWidget.dart';
import 'package:tecmas/Secciones/SharedClasses/NetworkImageBox.dart';
import 'package:tecmas/Secciones/SharedClasses/ZoomableImage.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:tecmas/Temas/BaseTheme.dart';


class Widget_Transporte extends StatefulWidget {
  @override
  _Widget_TransporteState createState() => _Widget_TransporteState();
}

class _Widget_TransporteState extends State<Widget_Transporte> {

  static const List<String> ruta=[
    /*Ruta 1: */ 'http://www.itmatamoros.edu.mx/wp-content/uploads/2019/02/Ruta-Tec-1-2019.jpg',
    /*Ruta 2: */ 'http://www.itmatamoros.edu.mx/wp-content/uploads/2019/02/Ruta-Tec-2-2019.jpg',
    /*Ruta 3: */ 'http://www.itmatamoros.edu.mx/wp-content/uploads/2019/02/Ruta-Tec-3-2019.jpg',
    /*Ruta 4: */ 'http://www.itmatamoros.edu.mx/wp-content/uploads/2019/02/Ruta-Tec-1-2019.jpg',
  ];

  final NumeroDeRutas=ruta.length;

  bool isReloadFired=false;

  List<Widget> getTitleTabs(){
      List<Widget> tabs=[];
      for(int i=0; i<NumeroDeRutas; i++){
        tabs.add( Tab(child:Text("Ruta "+(i+1).toString())));
      }
      return tabs;
  }

  List<Widget> getBodyTabs(){
    List<Widget> body=[];
    for(int i=0; i<NumeroDeRutas; i++){
      body.add(isReloadFired ? LoadingWidget():
      InkWell(
        onTap: ()async{
          if(await NetworkConnectionCkeck()==1){
            Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => ZoomableImage(FromNetwork:ruta[i])),);
          }else{
            print("No se puede compa");
            ShowSnackWithDelay(ContextoDeVista, 1000, BasicSnack("Esta función esta desabilitada por el momento"));
          }

        },
        child: NetworkImageBox(URL: ruta[i],),
      ));
    }

    return body;



  }

  dynamic ContextoDeVista; //Esta variable es especifica para lanzar el mensaje "Esta funcion esta desabilitada por el momento" debido a que tienen diferente contexto


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: NumeroDeRutas,
      child: Scaffold(
        floatingActionButton: Builder(
          // Create an inner BuildContext so that the onPressed methods
          // can refer to the Scaffold with Scaffold.of().
            builder: (BuildContext context) {
              ContextoDeVista=context;
              return FloatingActionButton(
                heroTag: UniqueKey(),
                child: Icon(Icons.refresh),
                onPressed: ()async {
                  setState(() {
                    isReloadFired=true;
                  });

                  //
                  if(await NetworkConnectionCkeck()==1){
                      for(int i=0; i<NumeroDeRutas;i++){
                        setState(() {
                          DefaultCacheManager().removeFile(ruta[i]);
                        });
                      }
                      ShowSnackWithDelay(context, 500, BasicSnack("Se han Actualizado los Datos"));
                  }else{
                    ShowSnackWithDelay(context, 1000, BasicSnack("No es posible conectar con el servidor"));
                  }

                  //
                  setState((){

                    isReloadFired = false;

                  });


                },
              );}),
        appBar: CustomAppBar(
          preferredSize: Size.fromHeight(105.0),
          title: "Transporte",
          bottom: TabBar(
            isScrollable: true,
            tabs: getTitleTabs(),
          ),
        ),
        drawer: BarraDeNavegacion(),
        body: TabBarView(children: getBodyTabs(),),
      ),
    );
  }

}


