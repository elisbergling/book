import 'package:book/providers/state_provider.dart';
import 'package:book/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ExploreTypeRowBotton extends HookConsumerWidget {
  const ExploreTypeRowBotton({
    super.key,
    required this.text,
  });

  final String text;

  bool isList() {
    return text == 'List';
  }

  bool isSelected(bool isListState) {
    if (isList()) {
      return isList() && isListState;
    } else {
      return !isList() && !isListState;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isListState = ref.watch(exploreTypeIsListProvider);
    return Expanded(
      child: Container(
        height: 40,
        margin: const EdgeInsets.all(5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Material(
            color:
                isSelected(isListState) ? MyColors.purple : MyColors.darkGrey,
            child: InkWell(
              onTap: () {
                if (!isSelected(isListState)) {
                  ref.read(exploreTypeIsListProvider.notifier).state =
                      !isListState;
                }
              },
              child: Center(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: MyColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
