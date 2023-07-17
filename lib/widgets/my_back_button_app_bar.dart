import 'package:book/widgets/my_back_button.dart';
import 'package:flutter/material.dart';

class MyBackButtonAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const MyBackButtonAppBar({
    super.key,
    this.navigation,
  });

  final Function()? navigation;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(0),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: MyBackButton(dark: false, navigation: navigation),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
