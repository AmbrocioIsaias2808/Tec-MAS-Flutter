import 'package:flutter/material.dart';
import 'package:tecmas/Temas/BaseTheme.dart';

class Cabecera extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        image: DecorationImage(image: AssetImage("assets/Imagenes/logo.png")),
        /*gradient: LinearGradient(colors:<Color>[
            BaseThemeColor_DarkBlue,
            BaseThemeColor_DarkLightBlue
          ])*/
      ),
    );
  }
}
