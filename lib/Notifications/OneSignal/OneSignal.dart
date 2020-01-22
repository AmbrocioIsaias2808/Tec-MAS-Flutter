
import 'dart:convert';

import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter/material.dart';
import 'package:tecmas/Secciones/SharedClasses/Articles/NotificationArticleViewer.dart';

import '../../main.dart';
import 'dart:io' show Platform;
import 'dart:async';

class NotificationSystem{

  GlobalKey<NavigatorState> navigatorKey;

  NotificationSystem();

  void setNavigator( GlobalKey<NavigatorState> nav){
    navigatorKey=nav;
  }

  Future<void> init() async{
    print("Configurando notificaciones");
    OneSignal.shared.init(
        "b43ebbab-e2b2-4b03-8496-0e054bac7c31",

        iOSSettings: {
          OSiOSSettings.autoPrompt: false,
          OSiOSSettings.inAppLaunchUrl: true,
        }
    );
    OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);


    OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result)async{

      print("Opened notification: \n${result.notification.jsonRepresentation().replaceAll('"', '')}");
      //String a= result.notification.payload.jsonRepresentation().replaceAll('"{', '{').replaceAll('}"', '}');

      //print("Opened notification: \n${a}");
     await NotificationArticleOpener(jsonDecode(result.notification.payload.jsonRepresentation().replaceAll('"{', '{').replaceAll('}"', '}')));
      //navigatorKey.currentState.pushNamed('/SII');
    });

    if(await SharedPreferenceManager.readBool(SharedPreferenceManager.Key_CIDN)==false){
      notificationInitConfiguration();
    }

  }


  void NotificationArticleOpener(var jsonData)async{

    try{
      String a = jsonData['custom']['u'].toString();
      print("Tiene link: "+a.substring(0,48));
      if(a.substring(0,48)=="https://wordpresspruebas210919.000webhostapp.com"){
        print("Local link");
        navigatorKey.currentState.popUntil(ModalRoute.withName("/"));
        //navigatorKey.currentState.pushNamedAndRemoveUntil("/", (r) => false);
        navigatorKey.currentState.push(MaterialPageRoute(builder: (context)=>NotificationArticleViewer(articleID: a.substring(52),)));
        if(await SharedPreferenceManager.readBool(SharedPreferenceManager.Key_CIDN)==false){
          print("Not registeres");
          await SharedPreferenceManager.saveBool(SharedPreferenceManager.Key_CIDN, true);
        }else{
          print("Ya esta configurada esta wea");
        }
      }else{
        print("External link");
      }
      //
    }catch (e){
      print("No tiene link");
    }



  }

  void notificationInitConfiguration() async {
    var status = await OneSignal.shared.getPermissionSubscriptionState();
    var notification=OSCreateNotification(
      playerIds: [status.subscriptionStatus.userId],
      heading: "Configuración Inicial",
      content: "Por favor haz click aquí para configurar la apertura de notificaciones. Puedes elegir abrirlas directamente en la aplicación o en tu navegador favorito. En cualquier caso te redirigiremos a un articulo de prueba, despues de ello la configuración habrá terminado. (Si ya has configurado esto previamente ignora el mensaje)",
      url: "https://wordpresspruebas210919.000webhostapp.com/?p=548",
    );
    print("mandando notificacion");

    var response = await OneSignal.shared.postNotification(notification);

    /*
    *

    this.setState(() {
      _debugLabelString = "Sent notification with response: $response";
    });
    * */
  }






}