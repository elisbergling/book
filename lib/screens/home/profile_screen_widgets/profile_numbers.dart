import 'package:book/providers/state_provider.dart';
import 'package:book/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileNumbers extends HookConsumerWidget {
  const ProfileNumbers({
    super.key,
    required this.title,
    required this.amount,
    required this.index,
  });

  final String title;
  final int amount;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(profileListTypeIndexProvider.notifier).state = index;
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            amount.toString(),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: MyColors.darkGrey,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              color: MyColors.black,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
