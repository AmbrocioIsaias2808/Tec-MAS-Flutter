import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tecmas/Secciones/SharedClasses/Messeges/Errors/MSG_NetworkConnectionError.dart';

class NetworkImageBox extends StatelessWidget {

  final String URL;
  final double height;
  final double width;
  NetworkImageBox({@required this.URL, this.height=200, this.width=double.infinity});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width, height:height ,child: FittedBox(
      child: CachedNetworkImage(
        placeholder: (context,url)=>CircularProgressIndicator(strokeWidth: 0.8,),
        errorWidget:(context, url, error) => MSG_NetworkConnectionError(),
        imageUrl:URL,
      ),
      fit: BoxFit.scaleDown,
    ),
    );
  }
}
