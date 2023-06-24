import 'package:book/style/colors.dart';
import 'package:book/widgets/submit_button.dart';
import 'package:flutter/material.dart';

class RowSubmitButton extends StatelessWidget {
  const RowSubmitButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
    this.isFilled = false,
  });

  final Function() onPressed;
  final IconData icon;
  final String text;
  final bool isFilled;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SubmitButton(
        onPressed: onPressed,
        isFilled: isFilled,
        heigth: 40,
        isRow: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
              ),
              const SizedBox(width: 5),
              Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: MyColors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
