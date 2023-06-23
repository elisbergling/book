import 'package:book/models/chip.dart';
import 'package:book/screens/home/explore_screen_widgets/my_filter_chip.dart';
import 'package:book/utils/enums.dart';
import 'package:book/utils/lists.dart';
import 'package:flutter/material.dart';

class Chips {
  static Widget wrapChips(bool isAddBook, ChipType type) {
    List<String> list;
    switch (type) {
      case ChipType.genre:
        list = Lists.genres;
        break;
      case ChipType.language:
        list = Lists.langueges;
        break;
      case ChipType.sortBy:
        list = Lists.sortBy;
        break;
    }
    return Wrap(
      children: [
        for (String item in list)
          MyFilterChip(
            isAddBook: isAddBook,
            chip: MyChip(
              type: type,
              label: item,
            ),
          ),
      ],
    );
  }
}
