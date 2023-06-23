import 'package:book/services/chip_state_service.dart';
import 'package:book/services/slider_state_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final chipChnageNotifierProvider =
    ChangeNotifierProvider<ChipState>((ref) => ChipState(isAddBook: false));

final addBookChipChnageNotifierProvider =
    ChangeNotifierProvider<ChipState>((ref) => ChipState(isAddBook: true));

final sliderChnageNotifierProvider =
    ChangeNotifierProvider<SliderState>((ref) => SliderState());
