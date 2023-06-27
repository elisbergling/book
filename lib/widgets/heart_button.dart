import 'package:book/widgets/circular_button.dart';
import 'package:flutter/material.dart';

class HeartButton extends StatelessWidget {
  const HeartButton({
    super.key,
    this.size = 55,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return CircularButton(
      icon: Icons.favorite_outline_rounded,
      onPressed: () {},
      dark: true,
      size: size,
    );
  }
}
