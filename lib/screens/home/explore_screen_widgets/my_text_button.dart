import 'package:book/style/colors.dart';
import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.isFilled,
  });

  final Function() onPressed;
  final String text;
  final bool isFilled;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: isFilled ? MyColors.purple : MyColors.black,
          minimumSize: const Size.fromHeight(45),
          maximumSize: const Size.fromHeight(75),
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: !isFilled
                ? const BorderSide(
                    width: 1,
                    color: MyColors.purple,
                  )
                : BorderSide.none,
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
