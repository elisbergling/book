import 'package:book/style/colors.dart';
import 'package:flutter/material.dart';

class ProfileNumbers extends StatelessWidget {
  const ProfileNumbers({super.key, required this.title, required this.amount});

  final String title;
  final int amount;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: MyColors.black,
            fontSize: 9,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          amount.toString(),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: MyColors.darkGrey,
          ),
        ),
      ],
    );
  }
}
