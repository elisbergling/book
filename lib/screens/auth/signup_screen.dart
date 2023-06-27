import 'package:book/screens/auth/signup_screen_widgets/or_divider.dart';
import 'package:book/widgets/my_text_field.dart';
import 'package:book/screens/auth/signup_screen_widgets/social_login_button.dart';
import 'package:book/screens/home/home_screen.dart';
import 'package:book/style/colors.dart';
import 'package:book/utils/routes.dart';
import 'package:book/widgets/my_back_button_app_bar.dart';
import 'package:book/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SignUpScreen extends HookWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passowrdController = useTextEditingController();
    final confirmPassowrdController = useTextEditingController();
    final isSignUp = useState(true);
    return Scaffold(
      backgroundColor: MyColors.black,
      appBar: const MyBackButtonAppBar(),
      body: Column(
        children: [
          if (isSignUp.value)
            MyTextField(
              controller: nameController,
              labelText: 'Name',
              keyBoardType: TextInputType.name,
            ),
          MyTextField(
            controller: emailController,
            labelText: 'Email',
            keyBoardType: TextInputType.emailAddress,
          ),
          MyTextField(
            controller: passowrdController,
            labelText: 'Password',
            obscureText: true,
          ),
          if (isSignUp.value)
            MyTextField(
              controller: confirmPassowrdController,
              labelText: 'Confirm Password',
              obscureText: true,
            ),
          SubmitButton(
            onPressed: () {
              Navigator.of(context).push(MyRoutes.fromRigth(HomeScreen()));
            },
            heigth: 40,
            child: Center(
              child: Text(
                isSignUp.value ? 'Create an Account' : 'Log In',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const OrDivider(),
          SocialLoginButton(
            buttonType: SocialLoginButtonType.google,
            onPressed: () {},
          ),
          SocialLoginButton(
            buttonType: SocialLoginButtonType.apple,
            onPressed: () {},
          ),
          SocialLoginButton(
            buttonType: SocialLoginButtonType.facebook,
            onPressed: () {},
          ),
          SocialLoginButton(
            buttonType: SocialLoginButtonType.twitter,
            onPressed: () {},
          ),
          SocialLoginButton(
            buttonType: SocialLoginButtonType.github,
            onPressed: () {},
          ),
          const Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isSignUp.value
                    ? 'Already have an account?'
                    : 'Don\'t have an account yet?',
                style: const TextStyle(color: MyColors.white),
              ),
              TextButton(
                  onPressed: () => isSignUp.value = !isSignUp.value,
                  child: Text(isSignUp.value ? 'Log In' : 'Create Acount')),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
