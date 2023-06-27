import 'package:book/style/colors.dart';
import 'package:flutter/material.dart';

class WhiteTextTitle extends StatelessWidget {
  const WhiteTextTitle({
    super.key,
    required this.text,
    this.isAddBook = false,
  });

  final String text;
  final bool isAddBook;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isAddBook ? const EdgeInsets.only(left: 20) : EdgeInsets.zero,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            text,
            style: const TextStyle(
              color: MyColors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
