import 'package:book/screens/auth/first_screen.dart';
import 'package:book/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  //await Firebase.initializeApp(
  //  options: DefaultFirebaseOptions.currentPlatform,
  //);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
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
      home: const FirstScreen(),
    );
  }
}
