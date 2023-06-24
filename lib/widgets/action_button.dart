import 'package:book/style/colors.dart';
import 'package:book/widgets/submit_button.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isFilled = true,
  });

  final String text;
  final Function() onPressed;
  final bool isFilled;

  @override
  Widget build(BuildContext context) {
    return SubmitButton(
      heigth: 40,
      onPressed: onPressed,
      isFilled: isFilled,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isFilled ? MyColors.black : MyColors.white,
          ),
        ),
      ),
    );
  }
}
