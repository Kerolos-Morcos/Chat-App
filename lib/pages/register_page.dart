import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/auth/auth_cubit.dart';
import 'package:chat_app/helper/route_animation.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  static String id = 'RegisterPage';

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();
    late String email, password, username;
    bool isLoading = false;
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          isLoading = false;
          showSnackBar(
            context,
            'Sign Up Successful, you will be directed to login page',
            backgroundColor: Colors.green,
          );
          Navigator.of(context).pop();
        } else if (state is RegisterFailure) {
          isLoading = false;
          showSnackBar(
            context,
            state.errorMessage,
            backgroundColor: Colors.red,
          );
        }
      },
      builder: (context, state) {
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
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(context).registerUser(
                              email: email,
                              password: password,
                              username: username);
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
      },
    );
  }
}
