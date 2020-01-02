import 'package:flutter/material.dart';
import 'package:tecmas/Temas/BaseTheme.dart';


class CustomAppBar extends StatefulWidget implements PreferredSizeWidget{

  String title;
  List<Widget> actions;
  PreferredSizeWidget bottom;
  Key key;
  static const dynamic Height=Size.fromHeight(56.0);

  static const List<Widget> vacio=[];

  CustomAppBar({this.title="", this.actions=vacio, this.bottom , this.key, this.preferredSize=Height}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState(title: title, actions: actions, bottom: bottom, key: key);

  @override
  final Size preferredSize;
}

class _CustomAppBarState extends State<CustomAppBar> {
  String title;
  List<Widget> actions;
  PreferredSizeWidget bottom;
  Key key;

  static const List<Widget> vacio=[];

  _CustomAppBarState({this.title="", this.actions=vacio, this.bottom, this.key });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      key: key,
      title: Text(title),
      bottom: bottom,
      actions: actions,
      backgroundColor: BaseThemeColor_DarkLightBlue.withOpacity(0.7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(0)
        ),),
    );

  }
}
