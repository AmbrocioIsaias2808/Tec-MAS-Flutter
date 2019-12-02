import 'package:flutter/material.dart';

class MSG_NetworkConnectionError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Icon(Icons.network_check,size: 50,),
      Text("Fallo de Conexión a Internet", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
    ],
    );
  }
}
