import 'package:book/style/colors.dart';
import 'package:flutter/material.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key, this.isBig = true});

  final bool isBig;

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
          'Stockholm',
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
