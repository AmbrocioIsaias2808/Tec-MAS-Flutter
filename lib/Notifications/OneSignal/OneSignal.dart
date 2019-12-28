
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter/material.dart';
import 'package:tecmas/Secciones/Transporte/Widget_Transporte.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';
import 'package:android_intent/android_intent.dart';
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


    OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {

      print("Opened notification: \n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}");
      //NavigateTo.jumpToPage(5);
      MaterialPageRoute(builder: (context) => Widget_Transporte());

    });

  }

  void call() async{
    const url = 'geo:52.32,4.917';

    if (await canLaunch(url)) {
      await launch(url);
    } else {

        throw 'Could not launch $url';

    }
  }





}