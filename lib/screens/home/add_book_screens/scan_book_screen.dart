import 'package:book/style/colors.dart';
import 'package:book/widgets/my_back_button_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ScanBookScreen extends HookWidget {
  const ScanBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyBackButtonAppBar(),
      body: Center(
        child: Text(
          'Good Luck',
          style: TextStyle(
            color: MyColors.white,
          ),
        ),
      ),
    );
  }
}
