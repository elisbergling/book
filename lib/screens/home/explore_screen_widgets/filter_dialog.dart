import 'package:book/providers/change_notifier_provider.dart';
import 'package:book/providers/state_provider.dart';
import 'package:book/screens/home/add_book_screens/enter_dattails_manually_screen_widgets/row_submit_button.dart';
import 'package:book/screens/home/explore_screen_widgets/my_text_button.dart';
import 'package:book/style/colors.dart';
import 'package:book/utils/chips.dart';
import 'package:book/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FilterDialog extends HookConsumerWidget {
  const FilterDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sliderState = ref.watch(sliderChnageNotifierProvider);
    final isBuy = ref.watch(isBuyProvider);
    final isRent = ref.watch(isRentProvider);
    final isSwap = ref.watch(isSwapProvider);
    return Container(
      decoration: const BoxDecoration(
        color: MyColors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Genre',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Chips.wrapChips(false, ChipType.genre),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Price',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${sliderState.price.toStringAsFixed(0)} sek',
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Slider(
                value: sliderState.price,
                onChanged: (double value) {
                  ref.read(sliderChnageNotifierProvider.notifier).price = value;
                },
                activeColor: MyColors.purple,
                inactiveColor: MyColors.darkGrey,
                divisions: 5000,
                min: 0,
                max: 5000,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Rating',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${sliderState.rating.toStringAsFixed(1)} or more',
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Slider(
                value: sliderState.rating,
                onChanged: (double value) {
                  ref.read(sliderChnageNotifierProvider.notifier).rating =
                      value;
                },
                activeColor: MyColors.purple,
                inactiveColor: MyColors.darkGrey,
                divisions: 40,
                min: 1,
                max: 5,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Distance',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${sliderState.distance.toStringAsFixed(1)} km',
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Slider(
                value: sliderState.distance,
                onChanged: (double value) {
                  ref.read(sliderChnageNotifierProvider.notifier).distance =
                      value;
                },
                activeColor: MyColors.purple,
                inactiveColor: MyColors.darkGrey,
                divisions: 10000,
                min: 0.1,
                max: 1000.0,
              ),
              const SizedBox(height: 20),
              const Text(
                'Language',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Chips.wrapChips(false, ChipType.language),
              const SizedBox(height: 20),
              const Text(
                'Sort by',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Chips.wrapChips(false, ChipType.sortBy),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    RowSubmitButton(
                      onPressed: () =>
                          ref.read(isBuyProvider.notifier).state = !isBuy,
                      icon: Icons.sell_outlined,
                      text: 'Sell',
                      isFilled: isBuy,
                    ),
                    RowSubmitButton(
                      onPressed: () =>
                          ref.read(isBuyProvider.notifier).state = !isRent,
                      icon: Icons.timer_outlined,
                      text: 'Lease',
                      isFilled: isRent,
                    ),
                    RowSubmitButton(
                      onPressed: () =>
                          ref.read(isBuyProvider.notifier).state = !isSwap,
                      icon: Icons.swap_horiz_rounded,
                      text: 'Swap',
                      isFilled: isSwap,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyTextButton(
                    onPressed: () {
                      ref.read(sliderChnageNotifierProvider.notifier).cancel();
                      ref.read(chipChnageNotifierProvider.notifier).cancel();
                      Navigator.pop(context);
                    },
                    text: 'Cancel',
                    isFilled: false,
                  ),
                  const SizedBox(width: 20),
                  MyTextButton(
                    onPressed: () {
                      ref.read(sliderChnageNotifierProvider.notifier).apply();
                      ref.read(chipChnageNotifierProvider.notifier).apply();
                      Navigator.pop(context);
                    },
                    text: 'Apply',
                    isFilled: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
