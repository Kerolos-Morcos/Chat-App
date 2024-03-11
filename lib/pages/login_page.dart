import 'package:chat_app/constants.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Form(
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
              CustomTextField(
                hintText: "Email",
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                hintText: "Password",
              ),
              const SizedBox(
                height: 23,
              ),
              const CustomButton(
                buttonText: 'Sign In',
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
                      routeAnimation(context);
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
    );
  }

  void routeAnimation(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            RegisterPage(),
        transitionsBuilder:
            (context, animation, secondaryAnimation, child) {
          var begin = 0.0;
          var end = 1.0;
          var curve = Curves.ease;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve)).animate(animation);
          return FadeTransition(
              opacity: tween,
              child: child,
            
          );
        },
        transitionDuration: const Duration(seconds: 1),
      ),
    );
  }
}
