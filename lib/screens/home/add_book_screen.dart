import 'package:book/screens/home/add_book_screens/enter_details_maually_screen.dart';
import 'package:book/screens/home/add_book_screens/scan_book_screen.dart';
import 'package:book/style/colors.dart';
import 'package:book/utils/routes.dart';
import 'package:book/widgets/action_button.dart';
import 'package:book/widgets/submit_button.dart';
import 'package:flutter/material.dart';

class AddBookScreen extends StatelessWidget {
  const AddBookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SubmitButton(
            onPressed: () async => await Navigator.of(context).push(
              MyRoutes.fromRigth(const ScanBookScreen()),
            ),
            heigth: 40,
            child: const Center(
              child: Text(
                'Scan Your Book',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          ActionButton(
            text: 'Enter Details Manually',
            isFilled: false,
            onPressed: () async => await Navigator.of(context).push(
              MyRoutes.fromRigth(const EnterDetailsManuallyScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
