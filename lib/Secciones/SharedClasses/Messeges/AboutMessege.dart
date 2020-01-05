import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:tecmas/Secciones/SharedClasses/CommonlyUsed.dart';
import 'package:tecmas/main.dart';


//ybugjguyñ
void AboutMessege(dynamic context) async{
  int a=0;
  String BaseProgrammer="Ambrocio Isaías Laureano Castro";
  // flutter defined function
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
  showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context)
          .modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext,
          Animation animation,
          Animation secondaryAnimation) {
        return Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 20,
            height: MediaQuery.of(context).size.height -  200,
            padding: EdgeInsets.all(20),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 3.0,
              color: Colors.white,
              child: ListView(
                padding: const EdgeInsets.all(0.0),
                children: <Widget>[
                  SizedBox(height: 0.0,),
                  Image.asset('assets/Imagenes/programmer.gif',),
                  SizedBox(height: 16.0,),
                  Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0),child:
                  Row(children: <Widget>[Text("Versión: ", style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(version, style: TextStyle(fontWeight: FontWeight.bold),),],),),
                  SizedBox(height: 16.0,),
                  Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0),child:
                  Wrap(
                    alignment: WrapAlignment.start,
                    children: <Widget>[
                      Text("Programador: ", style: TextStyle(fontWeight: FontWeight.bold),),
                      FlatButton(child: Text(BaseProgrammer, softWrap: true,),
                        onPressed: (){
                        },
                      )
                    ],),
                  ),

                  FlatButton(
                    padding: EdgeInsets.all(0.0),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Cerrar",
                      style: TextStyle(color: Colors.green),
                    ),
                  )
                ],
              ),),
          ),
        );
      });

}