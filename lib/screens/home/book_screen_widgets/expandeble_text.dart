import 'package:book/style/colors.dart';
import 'package:flutter/material.dart';

class ExpandebleText extends StatelessWidget {
  const ExpandebleText({super.key, required this.showAllText});

  final ValueNotifier<bool> showAllText;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'lvldffd dvdfvdfvdvdfvdfvlvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffdlvldffdlvldffdlvldffdlvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd',
          style: const TextStyle(
            color: MyColors.ligthGrey,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          maxLines: showAllText.value ? null : 4,
          overflow: showAllText.value ? null : TextOverflow.ellipsis,
        ),
        TextButton(
          onPressed: () => showAllText.value = !showAllText.value,
          child: Text(
            showAllText.value ? 'Show Less' : 'Show More',
          ),
        ),
      ],
    );
  }
}
