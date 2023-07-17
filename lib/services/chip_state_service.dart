import 'package:book/models/chip.dart';
import 'package:book/utils/enums.dart';
import 'package:flutter/material.dart';

class ChipState extends ChangeNotifier {
  ChipState({required this.isAddBook});

  final bool isAddBook;

  late final Map<ChipType, List<MyChip>> _startState = isAddBook
      ? {
          ChipType.genre: [],
          ChipType.language: [],
        }
      : {
          ChipType.genre: [],
          ChipType.language: [],
          ChipType.sortBy: [
            const MyChip(
              label: 'Price Increasing',
              type: ChipType.sortBy,
            )
          ],
        };

  late Map<ChipType, List<MyChip>> tempState = _deepCopy(_startState);
  late Map<ChipType, List<MyChip>> realState = _deepCopy(_startState);

  bool isMarked(MyChip chip) {
    return tempState[chip.type]!.any((element) => element.label == chip.label);
  }

  void toogle(MyChip chip) {
    ChipType type = isAddBook ? ChipType.language : ChipType.sortBy;
    if (isMarked(chip) && chip.type != type) {
      tempState[chip.type]!
          .removeWhere((element) => element.label == chip.label);
    } else {
      if (chip.type == type) {
        tempState[chip.type]!.clear();
      }
      tempState[chip.type]!.add(chip);
    }
    notifyListeners();
  }

  void apply() {
    realState = _deepCopy(tempState);
    notifyListeners();
  }

  void cancel() {
    tempState = _deepCopy(realState);
    notifyListeners();
  }

  List<MyChip> _deepCopyList(List<MyChip> list) {
    return list.map((chip) => MyChip.copy(chip)).toList();
  }

  Map<ChipType, List<MyChip>> _deepCopy(Map<ChipType, List<MyChip>> map) {
    return map.map((key, value) => MapEntry(key, _deepCopyList(value)));
  }
}
