import 'package:book/utils/enums.dart';

class MyChip {
  const MyChip({required this.label, required this.type});

  final String label;
  final ChipType type;

  MyChip.copy(MyChip other)
      : label = other.label,
        type = other.type;
}
