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
          fixedSize: const Size.fromHeight(50),
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
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
