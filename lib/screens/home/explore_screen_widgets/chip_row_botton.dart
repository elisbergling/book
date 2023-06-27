import 'package:book/screens/home/explore_screen_widgets/explore_type_row_botton.dart';
import 'package:flutter/material.dart';

class ChipRowBotton extends StatelessWidget implements PreferredSizeWidget {
  const ChipRowBotton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(0),
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SizedBox(width: 15),
            ExploreTypeRowBotton(text: 'List'),
            ExploreTypeRowBotton(text: 'Map'),
            SizedBox(width: 15),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(30);
}
