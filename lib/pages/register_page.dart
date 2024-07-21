// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/route_animation.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static String id = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email, password, username;
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();
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
                    fontSize: 32,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Row(
                  children: [
                    Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextFormField(
                  hintText: "Username",
                  onChanged: (value) {
                    username = value;
                  },
                  icon: Icons.person,
                  transparentColor: Colors.transparent,
                  clickSound: false,
                ),
                const SizedBox(
                  height: 10,
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
                  height: 10,
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
                  height: 25,
                ),
                CustomButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        UserCredential userCredential = await registerUser();
                        await userCredential.user!.updateDisplayName(username);
                        showSnackBar(
                          context,
                          'Sign Up Successful, you will be directed to login page',
                          backgroundColor: Colors.green,
                        );
                        Future.delayed(
                          const Duration(seconds: 4),
                          () {
                            Navigator.of(context).pop();
                          },
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(
                            context,
                            'The password provided is too weak.',
                            backgroundColor: Colors.red,
                          );
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(
                            context,
                            'The account already exists for that email.',
                            backgroundColor: Colors.red,
                          );
                        }
                      } catch (e) {
                        showSnackBar(
                          context,
                          'Sorry, an error occurred.',
                          backgroundColor: Colors.red,
                        );
                      }
                      setState(() {
                        isLoading = false;
                      });
                    } else {}
                  },
                  buttonText: 'Sign Up',
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(
                        color: Colors.grey[400],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        routeAnimationRegister(context);
                      },
                      child: const Text(
                        ' Login',
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
  Future<UserCredential> registerUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email!, password: password!);
    log(userCredential.user!.email!);
    final user = userCredential.user!;
    final firestore = FirebaseFirestore.instance;
    final docRef = firestore.collection('users').doc(user.uid);
    docRef.set({
      'username': username,
      'email': user.email,
    });
    return userCredential;
  }
}
