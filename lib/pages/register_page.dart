import 'package:chat_app/constants.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  static String id = 'RegisterPage';
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();
    return Scaffold(
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
                    'Register',
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
              CustomTextField(
                hintText: "Email",
                onChanged: (value) {
                  email = value;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                hintText: "Password",
                onChanged: (value) {
                  password = value;
                },
              ),
              const SizedBox(
                height: 23,
              ),
              CustomButton(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    try {
                      await registerNewUser();
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        showSnackbar(
                          context,
                          'The password provided is too weak.',
                          backgroundColor: Colors.red,
                        );
                      } else if (e.code == 'email-already-in-use') {
                        showSnackbar(
                          context,
                          'The account already exists for that email.',
                          backgroundColor: Colors.red,
                        );
                      }
                    } catch (e) {
                      showSnackbar(
                        context,
                        'Sorry, an error occurred.',
                        backgroundColor: Colors.red,
                      );
                    }
                  showSnackbar(
                    context,
                    'Sign Up Successful, you will be directed to login page',
                    backgroundColor: Colors.green,
                  );
                  Future.delayed(
                    const Duration(seconds: 6),
                    () {
                      Navigator.of(context).pop();
                    },
                  );
                  } else
                  {
                    
                  }
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
                      routeAnimation(context);
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
    );
  }

// Functions
  void routeAnimation(BuildContext context) {
    Navigator.of(context).pop(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = 0.0;
          var end = 1.0;
          var curve = Curves.ease;
          var tween = Tween(begin: begin, end: end)
              .chain(CurveTween(curve: curve))
              .animate(animation);
          return FadeTransition(
            opacity: tween,
            child: child,
          );
        },
        transitionDuration: const Duration(seconds: 1),
      ),
    );
  }

  void showSnackbar(BuildContext context, String message,
      {MaterialColor? backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(10),
        elevation: 10,
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
          textColor: Colors.white,
        ),
      ),
    );
  }

  Future<void> registerNewUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
    print(user.user!.email);
  }
}
