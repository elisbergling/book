import 'package:book/style/colors.dart';
import 'package:book/widgets/submit_button.dart';
import 'package:flutter/material.dart';

enum SocialLoginButtonType {
  facebook,
  google,
  twitter,
  apple,
  microsoft,
  github,
  generalLogin
}

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    Key? key,
    required this.buttonType,
    required this.onPressed,
  }) : super(key: key);

  final SocialLoginButtonType buttonType;

  final VoidCallback? onPressed;

  final _defaultImagePath = "lib/assets/logos/";

  @override
  Widget build(BuildContext context) {
    String? imageName;
    String? text;
    Widget? icon;
    Color? color;

    switch (buttonType) {
      case SocialLoginButtonType.facebook:
        text = "Facebook";
        imageName = "${_defaultImagePath}facebook-logo.png";
        color = const Color(0xFF334D92);
        icon = ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(imageName, scale: 2.5, color: color),
        );
        break;
      case SocialLoginButtonType.google:
        text = "Google";
        imageName = "${_defaultImagePath}google-logo.png";
        break;
      case SocialLoginButtonType.twitter:
        text = "Twitter";
        imageName = "${_defaultImagePath}twitter-logo.png";
        color = const Color(0xFF1DA1F2);
        break;
      case SocialLoginButtonType.apple:
        text = "Apple";
        imageName = "${_defaultImagePath}apple-logo.png";
        break;
      case SocialLoginButtonType.microsoft:
        text = "Microsoft";
        imageName = "${_defaultImagePath}microsoft-logo.png";
        break;
      case SocialLoginButtonType.github:
        text = "Github";
        imageName = "${_defaultImagePath}github-logo.png";
        break;
      case SocialLoginButtonType.generalLogin:
        text = "Email";
        icon = const Icon(
          Icons.email_outlined,
          size: 22,
        );
        break;
    }

    return SubmitButton(
      onPressed: () => onPressed,
      heigth: 40,
      isFilled: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: MediaQuery.of(context).size.width * 0.3 - 40),
          icon ?? Image.asset(imageName!, scale: 2.5, color: color),
          const SizedBox(width: 20),
          Text(
            'Continue with $text',
            style: const TextStyle(
              color: MyColors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
