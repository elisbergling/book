import 'package:book/models/chip.dart';
import 'package:book/providers/change_notifier_provider.dart';
import 'package:book/services/chip_state_service.dart';
import 'package:book/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
    return MyFilterChipWidget(
      isSelected: chipState.isMarked(chip),
      text: chip.label,
      onPressed: () => ref.read(provider().notifier).toogle(chip),
    );
  }
}

class MyFilterChipOther extends HookWidget {
  const MyFilterChipOther({
    super.key,
    required this.chipState,
    required this.text,
  });

  final ValueNotifier<bool> chipState;
  final String text;

  @override
  Widget build(BuildContext context) {
    return MyFilterChipWidget(
      text: text,
      onPressed: () => chipState.value = !chipState.value,
      isSelected: chipState.value,
    );
  }
}

class MyFilterChipWidget extends StatelessWidget {
  const MyFilterChipWidget({
    super.key,
    required this.isSelected,
    required this.text,
    required this.onPressed,
  });

  final bool isSelected;
  final String text;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: FilterChip(
        shape: StadiumBorder(
          side: BorderSide(
            width: 1.2,
            color: isSelected ? MyColors.purple : MyColors.ligthGrey,
          ),
        ),
        label: Text(text),
        selected: isSelected,
        onSelected: (_) => onPressed(),
        showCheckmark: false,
        selectedColor: MyColors.purple.withOpacity(0.1),
        backgroundColor: MyColors.darkGrey,
        labelStyle: const TextStyle(
          color: MyColors.white,
        ),
      ),
    );
  }
}
