import 'package:flutter/material.dart';

Color BaseThemeColor_DarkBlue = Color.fromRGBO(27, 55, 94,1);
Color BaseThemeColor_DarkLightBlue = Color.fromRGBO(1, 94, 193,1);
Color BaseThemeColor_LightGray= Color.fromRGBO(241,241,241,1);

Color BaseThemeAppBarColor= BaseThemeColor_DarkLightBlue;

TextStyle BaseThemeText_whiteBold1 = TextStyle(color: Colors.white, fontWeight: FontWeight.bold);


ThemeData BaseTheme(){

  final ThemeData Tema= ThemeData.light();


  /*Tema de texto*/
  TextTheme _BaseTextTheme(TextTheme base){
    return base.copyWith(
      headline: base.headline.copyWith(
        fontSize:22.0,
      )
    );
  }

  TabBarTheme _TabBarTheme(TabBarTheme tema){
    return tema.copyWith(
      indicator: BoxDecoration( border: Border(bottom: BorderSide(color: Colors.purple,width: 2)),),
    );

  }
  
  FloatingActionButtonThemeData _FloatingActionButtonTheme(FloatingActionButtonThemeData tema){
    return tema.copyWith(backgroundColor: Colors.blue);
  }

  IconThemeData _IconTheme(IconThemeData tema){
    return tema.copyWith(
      color: Colors.red,
    );
  }

  SnackBarThemeData _SnackBarTheme(SnackBarThemeData tema){
    return tema.copyWith(
      backgroundColor: BaseThemeColor_DarkBlue,
      actionTextColor: Colors.amber,
      contentTextStyle: TextStyle(fontWeight: FontWeight.bold),
    );
  }



  /*Declaración formal: */

  return Tema.copyWith(
    primaryColor: BaseThemeColor_DarkLightBlue,
    backgroundColor: BaseThemeColor_DarkBlue,
    scaffoldBackgroundColor: BaseThemeColor_DarkBlue,
    tabBarTheme:_TabBarTheme(Tema.tabBarTheme),
    floatingActionButtonTheme: _FloatingActionButtonTheme(Tema.floatingActionButtonTheme),
    snackBarTheme:_SnackBarTheme(Tema.snackBarTheme),
  );




}
