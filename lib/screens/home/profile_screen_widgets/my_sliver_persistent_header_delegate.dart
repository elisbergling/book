import 'dart:math';

import 'package:book/style/colors.dart';
import 'package:flutter/material.dart';

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final double gapHeigth;
  final ShapeBorder shapeBorder;
  final Widget foreground;
  final Widget background;

  MySliverPersistentHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.gapHeigth,
    required this.shapeBorder,
    required this.foreground,
    required this.background,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double progress =
        shrinkOffset >= gapHeigth ? gapHeigth : shrinkOffset;
    final ShapeBorder currentShapeBorder = shapeBorder.scale(progress);

    return Stack(
      children: [
        background,
        Container(
          decoration: ShapeDecoration(
            shape: currentShapeBorder,
            color: MyColors.black,
            shadows: const [
              BoxShadow(
                color: MyColors.darkGrey,
                blurRadius: 30,
                spreadRadius: 0,
              ),
            ],
          ),
          child: foreground,
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(MySliverPersistentHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        shapeBorder != oldDelegate.shapeBorder ||
        foreground != oldDelegate.foreground ||
        background != oldDelegate.background;
  }
}
