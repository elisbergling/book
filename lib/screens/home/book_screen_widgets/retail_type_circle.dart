import 'package:book/style/colors.dart';
import 'package:flutter/material.dart';

class RetailTypeCircle extends StatelessWidget {
  const RetailTypeCircle({
    super.key,
    required this.icon,
    required this.isSelected,
  });

  final IconData icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color:
            isSelected ? MyColors.purple.withOpacity(0.2) : MyColors.darkGrey,
        border: Border.all(
          color: isSelected ? MyColors.purple : MyColors.ligthGrey,
        ),
      ),
      child: Icon(
        icon,
        size: 18,
        color: isSelected ? MyColors.purple : MyColors.ligthGrey,
      ),
    );
  }
}
