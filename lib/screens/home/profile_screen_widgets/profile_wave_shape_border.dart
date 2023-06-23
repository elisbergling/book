import 'dart:math';

import 'package:flutter/material.dart';

class ProfileWaveShapeBorder extends ShapeBorder {
  const ProfileWaveShapeBorder({
    this.radius = 50,
    this.gapHeigth = 150,
  });

  final double radius;
  final double gapHeigth;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addPolygon(
        [
          Offset(0, rect.size.height - gapHeigth / 2),
          Offset(radius, rect.size.height - radius - gapHeigth / 2),
          Offset(radius, rect.size.height - gapHeigth / 2),
        ],
        false,
      )
      ..addArc(
          Rect.fromLTWH(
            0,
            rect.size.height - radius - gapHeigth / 2,
            radius * 2,
            radius * 2,
          ),
          pi,
          pi / 2)
      ..addPolygon(
        [
          Offset(
              rect.size.width, rect.size.height - radius * 2 - gapHeigth / 2),
          Offset(rect.size.width - radius,
              rect.size.height - radius - gapHeigth / 2),
          Offset(rect.size.width, rect.size.height - radius - gapHeigth / 2),
        ],
        false,
      )
      ..addArc(
        Rect.fromLTWH(
          rect.size.width - radius * 2,
          rect.size.height - radius * 3 - gapHeigth / 2,
          radius * 2,
          radius * 2,
        ),
        0,
        pi / 2,
      )
      ..addRect(Rect.fromLTWH(
        radius,
        rect.size.height - radius - gapHeigth / 2,
        rect.size.width - radius,
        radius,
      ))
      ..addRect(
        Rect.fromLTWH(0, 0, rect.size.width, rect.size.height),
      )
      //
      //
      ..addPolygon(
        [
          Offset(0, rect.size.height),
          Offset(radius, rect.size.height - radius),
          Offset(radius, rect.size.height),
        ],
        false,
      )
      ..addArc(
          Rect.fromLTWH(0, rect.size.height - radius, radius * 2, radius * 2),
          pi,
          pi / 2)
      ..addPolygon(
        [
          Offset(rect.size.width, rect.size.height - radius * 2),
          Offset(rect.size.width - radius, rect.size.height - radius),
          Offset(rect.size.width, rect.size.height - radius),
        ],
        false,
      )
      ..addArc(
        Rect.fromLTWH(
          rect.size.width - radius * 2,
          rect.size.height - radius * 3,
          radius * 2,
          radius * 2,
        ),
        0,
        pi / 2,
      )
      ..addRect(Rect.fromLTWH(
        radius,
        rect.size.height - radius,
        rect.size.width - radius,
        radius,
      ))
      ..addRect(
        Rect.fromLTWH(0, rect.size.height - gapHeigth / 2, rect.size.width,
            gapHeigth / 2),
      )
      ..fillType = PathFillType.evenOdd;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) {
    return ProfileWaveShapeBorder(radius: radius, gapHeigth: gapHeigth - t);
  }
}
