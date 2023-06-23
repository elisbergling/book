import 'package:book/style/colors.dart';
import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.dark,
  });

  final IconData icon;
  final Function() onPressed;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      height: 55,
      width: 55,
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
