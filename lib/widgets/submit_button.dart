import 'package:book/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.heigth = 60,
    this.isFilled = true,
    this.isRow = false,
  });

  final Function() onPressed;
  final Widget child;
  final double heigth;
  final bool isFilled;
  final bool isRow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heigth,
      padding: const EdgeInsets.all(1.2),
      margin: EdgeInsets.symmetric(horizontal: isRow ? 5 : 20, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            MyColors.blue,
            MyColors.purple,
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: isFilled ? Colors.transparent : Colors.black,
          child: InkWell(
            onTap: onPressed,
            child: child,
          ),
        ),
      ),
    );
  }
}
