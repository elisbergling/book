import 'package:book/style/colors.dart';
import 'package:flutter/material.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({
    super.key,
    this.isBig = true,
    required this.text,
  });

  final bool isBig;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          size: isBig ? 18 : 14,
          color: MyColors.ligthGrey,
        ),
        Text(
          text,
          style: TextStyle(
            color: MyColors.white,
            fontSize: isBig ? 16 : 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
