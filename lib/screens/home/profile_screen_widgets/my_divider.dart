import 'package:book/style/colors.dart';
import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 30,
      decoration: const BoxDecoration(
        color: MyColors.darkGrey,
        borderRadius: BorderRadius.all(
          Radius.circular(1),
        ),
      ),
    );
  }
}
