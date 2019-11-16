import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_image/network.dart';

class ZoomableImage extends StatelessWidget {
  final String FromAssets;
  final String FromNetwork;

  ZoomableImage({this.FromAssets="", this.FromNetwork=""});
  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: FromNetwork!= "" ? NetworkImageWithRetry(FromNetwork) : AssetImage(FromAssets)
    );
  }
}
