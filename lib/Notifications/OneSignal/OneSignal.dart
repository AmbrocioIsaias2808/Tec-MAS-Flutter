
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter/material.dart';
import 'package:tecmas/Secciones/Transporte/Widget_Transporte.dart';

import '../../main.dart';

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
      main();
      navigatorKey.currentState.pushNamed('/Mapa');

    });

  }





}