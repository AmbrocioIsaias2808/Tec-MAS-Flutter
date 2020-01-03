
import 'dart:convert';

import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter/material.dart';
import 'package:tecmas/Secciones/SharedClasses/Articles/NotificationArticleViewer.dart';
import 'package:tecmas/Secciones/Transporte/Widget_Transporte.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';
import 'dart:io' show Platform;
import 'dart:async';

class NotificationSystem{

  GlobalKey<NavigatorState> navigatorKey;

  NotificationSystem();

  void setNavigator( GlobalKey<NavigatorState> nav){
    navigatorKey=nav;
  }

  void init() async{


    OneSignal.shared.init(
        "b43ebbab-e2b2-4b03-8496-0e054bac7c31",

        iOSSettings: {
          OSiOSSettings.autoPrompt: false,
          OSiOSSettings.inAppLaunchUrl: true
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

  }


  void NotificationArticleOpener(var jsonData){

    try{
      String a = jsonData['custom']['u'].toString();
      print("Tiene link: "+a.substring(0,48));
      if(a.substring(0,48)=="https://wordpresspruebas210919.000webhostapp.com"){
        print("Local link");
        navigatorKey.currentState.popUntil(ModalRoute.withName("/"));
        //navigatorKey.currentState.pushNamedAndRemoveUntil("/", (r) => false);
        navigatorKey.currentState.push(MaterialPageRoute(builder: (context)=>NotificationArticleViewer(articleID: a.substring(52),)));
      }else{
        print("External link");
      }
      //
    }catch (e){
      print("No tiene link");
    }



  }






}