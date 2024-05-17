import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_user_name.dart';
import 'package:chat_app/models/messages.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomChatBubble extends StatelessWidget {
  CustomChatBubble(
      {super.key, required this.message, required this.username});
  Message message;
  String username = '';
  @override
  Widget build(BuildContext context) {
    message.username = username;
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(
        children: [
          getTitleText(message.username, MainAxisAlignment.start),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: const BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Text(
                message.body,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ),
          ),
          getTitleText('${message.createdAt.hour}:${message.createdAt.minute} ${message.createdAt.hour>12? 'PM': 'AM'}' , MainAxisAlignment.start),
          const SizedBox(height: 8,)
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomChatBubbleForFriend extends StatelessWidget {
  CustomChatBubbleForFriend({
    super.key,
    required this.messageBody,
    required this.username,
  });
  Message messageBody;
String username;
  @override
  Widget build(BuildContext context) {
     messageBody.username = username;
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Column(
        children: [
          getTitleText(messageBody.username, MainAxisAlignment.end),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: const BoxDecoration(
                color: kSecondaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                ),
              ),
              child: Text(
                messageBody.body,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ),
          ),
          getTitleText('${messageBody.createdAt.hour}:${messageBody.createdAt.minute} ${messageBody.createdAt.hour>12? 'PM': 'AM'}' , MainAxisAlignment.end),
          const SizedBox(height: 8,)
        ],
      ),
    );
  }
}
