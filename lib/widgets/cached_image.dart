import 'package:book/style/colors.dart';
import 'package:book/widgets/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String? imageUrl;
  final double dimension;
  final String name;
  final Color? color;
  final Color? textColor;
  final BoxFit fit;

  const CachedImage({
    super.key,
    required this.imageUrl,
    required this.dimension,
    required this.name,
    this.textColor,
    this.color,
    this.fit = BoxFit.cover,
  });

  Center errorWidget() {
    return Center(
      child: Text(
        name.split('')[0],
        textAlign: TextAlign.center,
        style: TextStyle(
          color: textColor ?? MyColors.black,
          fontWeight: FontWeight.bold,
          fontSize: dimension / 2.2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: dimension,
      width: dimension,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(dimension / 2),
        color: color ?? MyColors.blue,
      ),
      child: imageUrl != null
          ? CachedNetworkImage(
              imageUrl: imageUrl!,
              fit: fit,
              height: dimension,
              width: dimension,
              fadeInCurve: Curves.easeIn,
              fadeInDuration: const Duration(milliseconds: 300),
              placeholder: (context, url) => const LoadingWidget(),
              errorWidget: (context, url, error) => errorWidget(),
            )
          : errorWidget(),
    );
  }
}
