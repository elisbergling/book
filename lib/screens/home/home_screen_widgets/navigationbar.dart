import 'package:book/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:book/screens/home/home_screen_widgets/navigationbar_icon.dart';

class MyNavigationBar extends StatelessWidget {
  const MyNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width - 30,
      decoration: const BoxDecoration(
        color: MyColors.black,
        borderRadius: BorderRadius.all(Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: MyColors.black,
            blurStyle: BlurStyle.normal,
            blurRadius: 50,
            spreadRadius: -10,
            offset: Offset(0, 10),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          NavigationbarIcon(icon: FontAwesomeIcons.airbnb, index: 0),
          NavigationbarIcon(icon: FontAwesomeIcons.plus, index: 1),
          NavigationbarIcon(icon: FontAwesomeIcons.bookJournalWhills, index: 2),
          NavigationbarIcon(icon: Icons.abc, index: 3),
        ],
      ),
    );
  }
}
