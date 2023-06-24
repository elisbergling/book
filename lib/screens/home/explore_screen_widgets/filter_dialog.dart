import 'package:book/providers/change_notifier_provider.dart';
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
                onChanged: (value) {
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
                onChanged: (value) {
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
                onChanged: (value) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        ref
                            .read(sliderChnageNotifierProvider.notifier)
                            .cancel();
                        ref.read(chipChnageNotifierProvider.notifier).cancel();
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: MyColors.black,
                        fixedSize: const Size(120, 35),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            width: 1,
                            color: MyColors.purple,
                          ),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        ref.read(sliderChnageNotifierProvider.notifier).apply();
                        ref.read(chipChnageNotifierProvider.notifier).apply();
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: MyColors.purple,
                        fixedSize: const Size(120, 35),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Apply',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
