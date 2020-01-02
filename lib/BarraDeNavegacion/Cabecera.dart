import 'package:flutter/material.dart';
import 'package:tecmas/Temas/BaseTheme.dart';

class Cabecera extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 147,
      child: DrawerHeader(
        child: Column(
          children: <Widget>[

            Material(
              /* borderRadius: BorderRadius.all(Radius.circular(70.0)),*/
              color: Colors.white,
              child: Image.asset("assets/Imagenes/logo.png",height: 90,)
              /*Padding(padding: EdgeInsets.all(12),
                child:Image.asset("assets/Imagenes/LOGO_TECNM.png",width: 80,height: 80,)
            )*/
              ,
            ),
            /*Padding(child:Text("Tec-Mas",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),padding:EdgeInsets.fromLTRB(0, 5, 0, 10),) ,*/
          ],

        ),
        decoration: BoxDecoration(
          color:Colors.white,
          /*gradient: LinearGradient(colors:<Color>[
            BaseThemeColor_DarkBlue,
            BaseThemeColor_DarkLightBlue
          ])*/
        ),
      ),
    );
  }
}
