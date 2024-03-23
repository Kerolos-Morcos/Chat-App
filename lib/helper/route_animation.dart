import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:flutter/material.dart';

class ChatPageArguments {
  final String? email;

  ChatPageArguments({this.email});
}

void routeAnimationRegister(BuildContext context) {
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

void routeAnimationLogin(BuildContext context) {
  Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const RegisterPage(),
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

void routeAnimationChat(BuildContext context, String? email) {
  Navigator.of(context).push(
    PageRouteBuilder(
      settings: RouteSettings(name: '/chatPage', arguments: email),
      pageBuilder: (context, animation, secondaryAnimation) => ChatPage(),
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
