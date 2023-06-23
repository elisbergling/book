import 'package:book/models/chip.dart';
import 'package:book/providers/change_notifier_provider.dart';
import 'package:book/services/chip_state_service.dart';
import 'package:book/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyFilterChip extends HookConsumerWidget {
  const MyFilterChip({
    super.key,
    required this.chip,
    required this.isAddBook,
  });

  final MyChip chip;
  final bool isAddBook;

  ChangeNotifierProvider<ChipState> provider() {
    return isAddBook
        ? addBookChipChnageNotifierProvider
        : chipChnageNotifierProvider;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chipState = ref.watch(provider());
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        padding: const EdgeInsets.all(1.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: chipState.isMarked(chip)
                ? [
                    MyColors.blue,
                    MyColors.purple,
                  ]
                : [
                    Colors.white,
                    Colors.white,
                  ],
          ),
        ),
        child: FilterChip(
          label: Text(chip.label),
          selected: chipState.isMarked(chip),
          onSelected: (value) {
            ref.read(provider().notifier).toogle(chip);
          },
          showCheckmark: false,
          selectedColor: MyColors.black,
          backgroundColor: MyColors.darkGrey,
          labelStyle: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
