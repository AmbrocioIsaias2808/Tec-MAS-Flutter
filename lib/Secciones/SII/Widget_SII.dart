import 'package:flutter/material.dart';
import 'package:tecmas/Secciones/SharedClasses/CustomWebview.dart';

class Widget_SII extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomWebview(SITE:"http://mictlantecuhtli.itmatamoros.edu.mx/", clearCookies: true,clearCache: true,title: "SII", AlertMessege: true,);
  }
}
