import 'package:book/models/user.dart';
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
              : () async => await Navigator.of(context)
                  .push(MyRoutes.fromRigth(const ProfileScreen(isOwn: false))),
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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(
                        color: MyColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5),
                    LocationWidget(isBig: false, text: 'Stockholm'),
                  ],
                ),
                Expanded(child: Container()),
                CircularButton(
                  icon: Icons.message_outlined,
                  onPressed: () async => await Navigator.of(context)
                      .push(MyRoutes.fromRigth(MessagingScreen(
                    user: MyUser(
                      //FIX
                      uid: '56',
                      name: 'TIM',
                      username: 'vdfvd',
                      email: 'svf',
                      profileImageUrl: '',
                      followingUids: [],
                      conversationUids: [],
                    ),
                  ))),
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
