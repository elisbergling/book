import 'dart:ui';

import 'package:book/providers/state_provider.dart';
import 'package:book/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavigationbarIcon extends HookConsumerWidget {
  const NavigationbarIcon({
    super.key,
    required this.icon,
    required this.index,
  });

  final IconData icon;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int navigationbarIndex = ref.watch(navigationBarIndexProvider);
    return Expanded(
      child: Center(
        child: Stack(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(40),
                ),
                child: BackdropFilter(
                  filter: index == navigationbarIndex
                      ? ImageFilter.blur(sigmaX: 10, sigmaY: 10)
                      : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                  child: AnimatedContainer(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: MyColors.purple
                          .withOpacity(index == navigationbarIndex ? 0.1 : 0),
                      boxShadow: [
                        BoxShadow(
                          color: MyColors.purple
                              .withOpacity(index == navigationbarIndex ? 1 : 0),
                          spreadRadius: -10,
                          blurRadius: 8,
                          offset: const Offset(0, 6),
                        ),
                      ],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(40),
                      ),
                    ),
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeIn,
                  ),
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  ref.read(navigationBarIndexProvider.notifier).state = index;
                },
                child: AnimatedContainer(
                  height: 40,
                  width: 40,
                  duration: const Duration(milliseconds: 250),
                  child: Center(
                    child: FaIcon(
                      icon,
                      size: 20,
                      color: index == navigationbarIndex
                          ? MyColors.white
                          : MyColors.ligthGrey,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
