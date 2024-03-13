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

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email, password;
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
                  'assets/images/scholar.png',
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
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextFormField(
                  hintText: "Password",
                  onChanged: (value) {
                    password = value;
                  },
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
                        await userLogin();
                        showSnackBar(
                          context,
                          'Login Successfully !',
                          backgroundColor: Colors.green,
                        );
                        Future.delayed(
                          const Duration(seconds: 0),
                          () {
                            routeAnimationChat(context);
                          },
                        );
                      } 
                      // on FirebaseAuthException catch (e) {
                      //   if (e.code == 'user-not-found') {
                      //     print("User not found");
                      //     showSnackBar(
                      //       context,
                      //       'No user found for that email.',
                      //       backgroundColor: Colors.red,
                      //     );
                      //   } else if (e.code == 'wrong-password') {
                      //     print("Wrong password");
                      //     showSnackBar(
                      //       context,
                      //       'Wrong password provided for that user.',
                      //       backgroundColor: Colors.red,
                      //     );
                      //   }
                      // } 
                      catch (e) {
                        print("Error occurred: $e");
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
                        // Navigator.pushNamed(context, RegisterPage.id);
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
  Future<void> userLogin() async {
    // ignore: unused_local_variable
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }

  }
