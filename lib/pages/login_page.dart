// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/route_animation.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String id = 'LoginPage';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email, password;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  late UserCredential userCredential;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      progressIndicator: const CircularProgressIndicator(
        color: Colors.white,
        backgroundColor: Colors.grey,
      ),
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Image.asset(
                  kLogo,
                  height: 100,
                ),
                const Text(
                  textAlign: TextAlign.center,
                  'Chat App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Row(
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                CustomTextFormField(
                  hintText: "Email",
                  onChanged: (value) {
                    email = value;
                  },
                  icon: Icons.email,
                  transparentColor: Colors.transparent,
                  clickSound: false,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextFormField(
                  hintText: "Password",
                  onChanged: (value) {
                    password = value;
                  },
                  icon: Icons.lock,
                  obscureText: true,
                  afterPressIcon: Icons.lock_open_outlined,
                ),
                const SizedBox(
                  height: 23,
                ),
                CustomButton(
                  buttonText: 'Sign In',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        await loginUser();
                        var username = userCredential.user!.displayName;
                        showSnackBar(
                          context,
                          'Successfully Logged as $username !',
                          backgroundColor: Colors.green,
                        );
                        Future.delayed(
                          const Duration(seconds: 0),
                          () {
                            routeAnimationChat(context, email, username);
                          },
                        );
                      } catch (e) {
                        log("Error occurred: $e");
                        showSnackBar(
                          context,
                          'Sorry, email or password is incorrect !',
                          backgroundColor: Colors.red,
                        );
                      }
                      setState(() {
                        isLoading = false;
                      });
                    } else {}
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: TextStyle(
                        color: Colors.grey[400],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        routeAnimationLogin(context);
                      },
                      child: const Text(
                        ' Sign Up',
                        style: TextStyle(
                          color: Color(0xffC7EDE6),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Methods
  Future<UserCredential> loginUser() async {
    var auth = FirebaseAuth.instance;
    userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }
}
