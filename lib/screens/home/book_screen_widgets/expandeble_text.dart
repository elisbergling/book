import 'package:book/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ExpandebleText extends HookWidget {
  const ExpandebleText({
    super.key,
    required this.showAllText,
    required this.textHigth,
  });

  final ValueNotifier<bool> showAllText;
  final ValueNotifier<double> textHigth;

  @override
  Widget build(BuildContext context) {
    late double textHeight;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final text = Text(
              'lvldffd dvdfvdfvdvdfvdfvlvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffdlvldffdlvldffdlvldffdlvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd',
              style: const TextStyle(
                color: MyColors.ligthGrey,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              maxLines: showAllText.value ? null : 4,
              overflow: showAllText.value ? null : TextOverflow.ellipsis,
            );

            const textSpan = TextSpan(
              text:
                  'lvldffd dvdfvdfvdvdfvdfvlvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffdlvldffdlvldffdlvldffdlvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd lvldffd',
              style: TextStyle(
                color: MyColors.ligthGrey,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            );
            const textSpan2 = TextSpan(
              text: 'sdsdcsdc',
              style: TextStyle(
                color: MyColors.ligthGrey,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            );
            final textPainter =
                TextPainter(text: textSpan, textDirection: TextDirection.ltr);
            textPainter.layout(maxWidth: constraints.maxWidth);
            final textPainter2 =
                TextPainter(text: textSpan2, textDirection: TextDirection.ltr);
            textPainter2.layout(maxWidth: constraints.maxWidth);
            textHeight =
                textPainter.size.height - (textPainter2.size.height * 5);
            return text;
          },
        ),
        TextButton(
          onPressed: () {
            if (showAllText.value) {
              textHigth.value -= textHeight;
            } else {
              textHigth.value += textHeight;
            }
            showAllText.value = !showAllText.value;
          },
          child: Text(
            showAllText.value ? 'Show Less' : 'Show More',
          ),
        ),
      ],
    );
  }
}
