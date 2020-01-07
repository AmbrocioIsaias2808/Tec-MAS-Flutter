import 'package:flutter/material.dart';
import 'package:tecmas/Temas/BaseTheme.dart';


class CustomAppBar extends StatefulWidget implements PreferredSizeWidget{

  String title;
  List<Widget> actions;
  PreferredSizeWidget bottom;
  Key key;
  bool withShape;
  static const dynamic Height=Size.fromHeight(56.0);

  static const List<Widget> vacio=[];

  CustomAppBar({this.title="", this.actions=vacio, this.bottom , this.key, this.preferredSize=Height, this.withShape=true}) : super(key: key);

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
    return ClipPath(
      clipper: widget.withShape? figura():null,
      child: AppBar(
        key: key,
        title: Text(title),
        bottom: bottom,
        actions: actions,
        backgroundColor: BaseThemeColor_DarkLightBlue.withOpacity(0.9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(0)
          ),),
      ),
    );

  }
}


class figura extends CustomClipper<Path> {
  var radius=10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height-18);
    path.lineTo(18, size.height);
    path.lineTo(size.width-18, size.height);
    path.lineTo(size.width, size.height-18);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}