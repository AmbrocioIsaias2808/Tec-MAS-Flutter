import 'package:flutter/material.dart';
import 'package:tecmas/BarraDeNavegacion/Drawer.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:tecmas/Secciones/SharedClasses/CommonlyUsed.dart';
import 'package:tecmas/Secciones/SharedClasses/NetworkImageBox.dart';
import 'package:tecmas/Secciones/SharedClasses/ZoomableImage.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:tecmas/Temas/BaseTheme.dart';


class Widget_Transporte extends StatefulWidget {
  @override
  _Widget_TransporteState createState() => _Widget_TransporteState();
}

class _Widget_TransporteState extends State<Widget_Transporte> {
  @override
  Widget build(BuildContext context) {
    final List<String> ruta=[
      /*Ruta 1: */ 'http://www.itmatamoros.edu.mx/wp-content/uploads/2019/02/Ruta-Tec-1-2019.jpg',
      /*Ruta 2: */ 'http://www.itmatamoros.edu.mx/wp-content/uploads/2019/02/Ruta-Tec-2-2019.jpg',
      /*Ruta 3: */ 'http://www.itmatamoros.edu.mx/wp-content/uploads/2019/02/Ruta-Tec-3-2019.jpg',
      /*Ruta 4: */ 'http://www.itmatamoros.edu.mx/wp-content/uploads/2019/02/Ruta-Tec-1-2019.jpg',
    ];

    bool isReloadFired=false;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        floatingActionButton: Builder(
          // Create an inner BuildContext so that the onPressed methods
          // can refer to the Scaffold with Scaffold.of().
            builder: (BuildContext context) {
              return FloatingActionButton(
                heroTag: UniqueKey(),
                child: Icon(Icons.refresh),
                onPressed: ()async {
                  setState(() {
                    isReloadFired=true;
                  });

                  //
                  if(await NetworkConnectionCkeck()==1){
                      for(int i=0; i<ruta.length;i++){
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
        appBar: AppBar(
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(child:Text("Ruta 1")),
              Tab(child:Text("Ruta 2")),
              Tab(child:Text("Ruta 3")),
              Tab(child:Text("Ruta 4")),
            ],
          ),
          title: Text('Transporte'),

        ),
        drawer: BarraDeNavegacion(),
        body: TabBarView(

          children: [
            isReloadFired ? Center(child: CircularProgressIndicator(),):
            InkWell(
              onTap: (){
                Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => ZoomableImage(FromNetwork:ruta[0])),);
              },
              child: NetworkImageBox(URL: ruta[0],),
            ),

            isReloadFired ? Center(child: CircularProgressIndicator(),):
            InkWell(
              onTap: (){
                Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => ZoomableImage(FromNetwork:ruta[1])),);
              },
              child: NetworkImageBox(URL: ruta[1],),
            ),

            isReloadFired ? Center(child: CircularProgressIndicator(),):
            InkWell(
              onTap: (){
                Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => ZoomableImage(FromNetwork:ruta[2])),);
              },
              child: NetworkImageBox(URL: ruta[2],),
            ),

            isReloadFired ? Center(child: CircularProgressIndicator(),):
            InkWell(
              onTap: (){
                Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => ZoomableImage(FromNetwork:ruta[3])),);
              },
              child: NetworkImageBox(URL: ruta[3],),
            ),

          ],
        ),
      ),
    );
  }

}


