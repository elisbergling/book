import 'package:book/widgets/circular_button.dart';
import 'package:flutter/material.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({
    super.key,
    this.dark = false,
    this.navigation,
  });

  final bool dark;
  final Function()? navigation;

  @override
  Widget build(BuildContext context) {
    return CircularButton(
      icon: Icons.arrow_back_ios_new_rounded,
      onPressed: navigation ?? () => Navigator.of(context).pop(),
      dark: dark,
    );
  }
}
