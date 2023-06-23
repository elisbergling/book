import 'package:book/providers/state_provider.dart';
import 'package:book/screens/home/add_book_screen.dart';
import 'package:book/screens/home/explore_screen.dart';
import 'package:book/screens/home/home_screen_widgets/navigationbar.dart';
import 'package:book/screens/home/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  HomeScreen({super.key});

  final screens = [
    const ExploreScreen(),
    const AddBookScreen(),
    const ProfileScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int navigationbarIndex = ref.watch(navigationBarIndexProvider);
    return Stack(
      children: [
        screens[navigationbarIndex],
        const Positioned(
          bottom: 15,
          right: 15,
          left: 15,
          child: MyNavigationBar(),
        ),
      ],
    );
  }
}
