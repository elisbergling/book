import 'package:book/screens/home/book_screen_widgets/location_widget.dart';
import 'package:book/screens/home/messaging_screen.dart';
import 'package:book/screens/home/profile_screen.dart';
import 'package:book/style/colors.dart';
import 'package:book/utils/routes.dart';
import 'package:book/widgets/circular_button.dart';
import 'package:flutter/material.dart';

class SellerInfoCard extends StatelessWidget {
  const SellerInfoCard({
    super.key,
    this.isPreview = false,
  });

  final bool isPreview;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: MyColors.darkGrey,
        child: InkWell(
          onTap: isPreview
              ? () {}
              : () => Navigator.of(context)
                  .push(MyRoutes.fromRigth(const ProfileScreen())),
          child: Container(
            height: 80,
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'lib/assets/images/3D_hipster.jpg',
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Name',
                      style: TextStyle(
                        color: MyColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5),
                    LocationWidget(isBig: false),
                  ],
                ),
                Expanded(child: Container()),
                CircularButton(
                  icon: Icons.message_outlined,
                  onPressed: () => Navigator.of(context)
                      .push(MyRoutes.fromRigth(const MessagingScreen())),
                  dark: false,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}