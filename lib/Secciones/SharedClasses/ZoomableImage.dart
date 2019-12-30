import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_image/network.dart';
import 'package:tecmas/Secciones/SharedClasses/LoadingWidget.dart';

class ZoomableImage extends StatelessWidget {
  final String FromAssets;
  final String FromNetwork;

  ZoomableImage({this.FromAssets="", this.FromNetwork=""});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: PhotoView(
        minScale: 0.3,
        loadingChild: LoadingWidget(),
        imageProvider: FromNetwork!= "" ? NetworkImageWithRetry(FromNetwork) : AssetImage(FromAssets)
    ),);
  }
}
