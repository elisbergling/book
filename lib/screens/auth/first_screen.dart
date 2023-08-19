import 'package:book/screens/auth/signup_screen.dart';
import 'package:book/style/colors.dart';
import 'package:book/utils/routes.dart';
import 'package:book/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(40),
            ),
            child: Image.asset('lib/assets/images/3D_hipster.jpg'),
          ),
          const SizedBox(height: 40),
          const Text(
            'Welcome to',
            style: TextStyle(
              fontSize: 37,
              color: MyColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'BKSWP',
            style: GoogleFonts.modak(
              fontSize: 60,
              color: MyColors.white,
            ),
          ),
          Expanded(child: Container()),
          SubmitButton(
            onPressed: () async {
              await Navigator.of(context).push(
                MyRoutes.fromRigth(const SignUpScreen()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Get Started',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  Icon(
                    Icons.keyboard_double_arrow_right_rounded,
                    color: MyColors.black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
