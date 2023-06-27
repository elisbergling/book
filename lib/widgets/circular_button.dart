import 'package:book/style/colors.dart';
import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.dark,
    this.size = 55,
  }) : assert(size >= 31);

  final IconData icon;
  final Function() onPressed;
  final bool dark;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all((size - 31.0) / 2),
      height: size,
      width: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Material(
          color: dark
              ? MyColors.darkGrey.withOpacity(0.7)
              : MyColors.ligthGrey.withOpacity(0.4),
          child: InkWell(
            onTap: onPressed,
            child: Icon(
              icon,
              size: 16,
            ),
          ),
        ),
      ),
    );
  }
}
