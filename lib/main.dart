import 'package:book/firebase_options.dart';
import 'package:book/providers/auth_provider.dart';
import 'package:book/screens/auth/first_screen.dart';
import 'package:book/screens/home/home_screen.dart';
import 'package:book/screens/temp/error_screen.dart';
import 'package:book/screens/temp/loading_screen.dart';
import 'package:book/style/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateChanges = ref.watch(authStateChangesProvider);
    return MaterialApp(
      title: 'Book App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          backgroundColor: MyColors.darkGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        textTheme: GoogleFonts.quicksandTextTheme(),
        scaffoldBackgroundColor: MyColors.black,
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: MyColors.purple,
          onPrimary: MyColors.black,
          secondary: MyColors.blue,
          onSecondary: MyColors.black,
          error: Colors.redAccent,
          onError: MyColors.white,
          background: MyColors.black,
          onBackground: MyColors.white,
          surface: MyColors.darkGrey,
          onSurface: MyColors.white,
        ),
      ),
      home: authStateChanges.when(
        data: (user) => user != null ? HomeScreen() : const FirstScreen(),
        loading: () => const LoadingScreen(),
        error: (e, s) => ErrorScreen(e: e, s: s),
      ),
    );
  }
}
