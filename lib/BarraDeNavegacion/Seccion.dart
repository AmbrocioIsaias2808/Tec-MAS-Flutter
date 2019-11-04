import 'package:flutter/material.dart';
import 'package:tecmas/Temas/BaseTheme.dart';

class Seccion extends StatelessWidget {

  final SectionIcon;
  final String SectionText;
  final Color color;
  final Function accion;


  Seccion({@required this.SectionText, @required this.SectionIcon, this.color=Colors.black, this.accion=null});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
        child:Container(decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color:BaseThemeColor_LightGray))
        ),
          child: InkWell(

              splashColor: BaseThemeColor_LightGray,
              onTap: accion,
              child: Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(SectionIcon,color: color,),
                        Padding(padding: EdgeInsets.all(10.0),
                          child:Text(SectionText,style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold,color: color)) ,
                        ),

                      ],
                    ),
//                    Icon(Icons.arrow_drop_down),
                  ],

                ),
              )
          ),
        )
    );
  }
}
