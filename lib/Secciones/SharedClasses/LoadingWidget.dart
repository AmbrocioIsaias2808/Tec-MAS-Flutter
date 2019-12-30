import "package:flutter/material.dart";
import 'package:tecmas/Temas/BaseTheme.dart';

import 'Articles/NotificationArticleViewer.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
          child: SizedBox(
            height: 100,
            child: Stack(
              children: <Widget>[
                Center(
                  child: Container(
                    height: 100,width: 100,
                    child: CircularProgressIndicator(),
                  ),
                ),
                Center(child: Text("Cargando", style: BaseThemeText_whiteBold1,),
                )
              ],
            ),
          ),
        )
    );
  }
}
