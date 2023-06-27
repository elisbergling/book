import 'package:book/style/colors.dart';
import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            SizedBox(width: 20),
            Expanded(
              child: Divider(
                color: MyColors.ligthGrey,
              ),
            ),
            SizedBox(width: 10),
            Text(
              'or',
              style: TextStyle(color: MyColors.ligthGrey),
            ),
            SizedBox(width: 10),
            Expanded(child: Divider(color: MyColors.ligthGrey)),
            SizedBox(width: 20),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
