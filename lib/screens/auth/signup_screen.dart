import 'package:book/providers/auth_provider.dart';
import 'package:book/screens/auth/signup_screen_widgets/or_divider.dart';
import 'package:book/widgets/my_text_field.dart';
import 'package:book/screens/auth/signup_screen_widgets/social_login_button.dart';
import 'package:book/style/colors.dart';
import 'package:book/widgets/my_back_button_app_bar.dart';
import 'package:book/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignUpScreen extends HookConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final authState = ref.watch(authProvider);
    final nameController = useTextEditingController();
    final userNameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passowrdController = useTextEditingController();
    final confirmPassowrdController = useTextEditingController();
    final isSignUp = useState(true);
    return Scaffold(
      backgroundColor: MyColors.black,
      appBar: const MyBackButtonAppBar(),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isSignUp.value)
                MyTextField(
                  controller: nameController,
                  labelText: 'Name',
                  keyBoardType: TextInputType.name,
                  validator: (value) =>
                      value!.isEmpty ? 'Name can\'t be empty' : null,
                ),
              if (isSignUp.value)
                MyTextField(
                  controller: userNameController,
                  labelText: 'Username',
                  keyBoardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Username can\'t be empty';
                    } else if (true) {
                      //TODO implement to match against database
                      return null;
                    }
                  },
                ),
              MyTextField(
                  controller: emailController,
                  labelText: 'Email',
                  keyBoardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email can\'t be empty';
                    } else if (emailController.text.contains('@')) {
                      //emailController.text.
                      // AuthCredential(providerId: providerId, signInMethod: signInMethod)
                      return null;
                    } else if (true) {
                      //TODO implement email verification
                      return null;
                    }
                  }),
              MyTextField(
                  controller: passowrdController,
                  labelText: 'Password',
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password can\'t be empty';
                    } else if (value.length < 8) {
                      return 'Password must be atleast 8 carcters long';
                    }
                    return null;
                  }),
              if (isSignUp.value)
                MyTextField(
                  controller: confirmPassowrdController,
                  labelText: 'Confirm Password',
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name can\'t be empty';
                    } else if (passowrdController.text != value) {
                      return 'Confiramtion password must be the same as the password';
                    }
                    return null;
                  },
                ),
              SubmitButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (isSignUp.value) {
                      ref.read(authProvider).signUpWithEmail(
                            email: emailController.text,
                            password: passowrdController.text,
                          );
                    } else {
                      ref.read(authProvider).loginWithEmail(
                            email: emailController.text,
                            password: passowrdController.text,
                          );
                    }
                    if (authState.error != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            authState.error!,
                          ),
                        ),
                      );
                      //authState.error = null;
                    }
                  }
                },
                heigth: 40,
                isLoading: authState.isLoading,
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
                    child: Text(isSignUp.value ? 'Log In' : 'Create Acount'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
