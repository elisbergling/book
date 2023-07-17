import 'package:book/providers/auth_provider.dart';
import 'package:book/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: MyColors.black,
      body: Center(
        child: FilledButton(
          onPressed: () async => await ref.read(authProvider.notifier).logOut(),
          child: const Text('Sign Out'),
        ),
      ),
    );
  }
}
