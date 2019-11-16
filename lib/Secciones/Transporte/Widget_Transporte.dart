import 'package:flutter/material.dart';
import 'package:tecmas/BarraDeNavegacion/Drawer.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:tecmas/Secciones/SharedClasses/NetworkImageBox.dart';
import 'package:tecmas/Secciones/SharedClasses/ZoomableImage.dart';


class Widget_Transporte extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
        length: 4,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: (){print("Holis");},
          ),
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

                  InkWell(
                    onTap: (){
                      Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => ZoomableImage(FromNetwork:'http://www.itmatamoros.edu.mx/wp-content/uploads/2019/02/Ruta-Tec-1-2019.jpg')),);
                    },
                    child: NetworkImageBox(URL: 'http://www.itmatamoros.edu.mx/wp-content/uploads/2019/02/Ruta-Tec-1-2019.jpg',),
                  ),


                  InkWell(
                    onTap: (){
                      Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => ZoomableImage(FromNetwork:'http://www.itmatamoros.edu.mx/wp-content/uploads/2019/02/Ruta-Tec-2-2019.jpg')),);
                    },
                    child: NetworkImageBox(URL: 'http://www.itmatamoros.edu.mx/wp-content/uploads/2019/02/Ruta-Tec-2-2019.jpg',),
                  ),


                  InkWell(
                    onTap: (){
                      Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => ZoomableImage(FromNetwork:'http://www.itmatamoros.edu.mx/wp-content/uploads/2019/02/Ruta-Tec-3-2019.jpg')),);
                    },
                    child: NetworkImageBox(URL: 'http://www.itmatamoros.edu.mx/wp-content/uploads/2019/02/Ruta-Tec-3-2019.jpg',),
                  ),


                  InkWell(
                    onTap: (){
                      Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => ZoomableImage(FromNetwork:'http://www.itmatamoros.edu.mx/wp-content/uploads/2019/02/Ruta-Tec-1-2019.jpg')),);
                    },
                    child: NetworkImageBox(URL: 'http://www.itmatamoros.edu.mx/wp-content/uploads/2019/02/Ruta-Tec-1-2019.jpg',),
                  ),

                ],
                ),
                ),
                );
  }
}



