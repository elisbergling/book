import 'package:book/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ExpandebleText extends HookWidget {
  const ExpandebleText({
    super.key,
    required this.onPressed,
    required this.showAllText,
    required this.text,
  });

  final Function() onPressed;
  final ValueNotifier<bool> showAllText;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          text,
          style: const TextStyle(
            color: MyColors.ligthGrey,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          maxLines: showAllText.value ? null : 4,
          overflow: showAllText.value ? null : TextOverflow.ellipsis,
        ),
        TextButton(
          onPressed: () {
            showAllText.value = !showAllText.value;
            onPressed();
          },
          child: Text(
            showAllText.value ? 'Show Less' : 'Show More',
          ),
        ),
      ],
    );
  }
}
