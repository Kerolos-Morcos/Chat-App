// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/login/login_cubit.dart';
import 'package:chat_app/helper/route_animation.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatelessWidget {
  static String id = 'LoginPage';
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();
    late String email, password;
    bool isLoading = false;

    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          isLoading = false;
          var name = BlocProvider.of<LoginCubit>(context).username;
          showSnackBar(
            context,
            'Successfully Logged as $name !',
            backgroundColor: Colors.green,
          );
          routeAnimationChat(context, email, name);
        } else if (state is LoginFailure) {
          isLoading = false;
          log("Error occurred: ${state.errorMessage}");
          showSnackBar(
            context,
            state.errorMessage,
            backgroundColor: Colors.red,
          );
        }
      },
      child: ModalProgressHUD(
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
                    onTap: () async{
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<LoginCubit>(context)
                            .loginUser(email: email, password: password);
                      }
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
      ),
    );
  }
}
