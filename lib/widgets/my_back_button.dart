import 'package:book/widgets/circular_button.dart';
import 'package:flutter/material.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({super.key, this.dark = false});

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return CircularButton(
      icon: Icons.arrow_back_ios_new_rounded,
      onPressed: () => Navigator.of(context).pop(),
      dark: dark,
    );
  }
}
