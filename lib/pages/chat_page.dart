import 'package:chat_app/constants.dart';
import 'package:chat_app/widgets/custom_chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:chat_bubbles/chat_bubbles.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});
  static String id = 'chatPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 212, 211, 211),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        scrolledUnderElevation: 0,
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              kLogo,
              height: 60,
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              'Chat',
              style: TextStyle(
                fontSize: 23,
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return const CustomChatBubble();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Send Message',
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.send,
                    color: kPrimaryColor,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: kPrimaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: kPrimaryColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// Chat Bubble Code
        // padding: const EdgeInsets.only(top: 16, bottom: 16,),
        // child: const BubbleSpecialThree(
        //   text: 'Hello',
        //   color: kPrimaryColor,
        //   tail: true,
        //   textStyle: TextStyle(
        //     color: Colors.white,
        //     fontSize: 20,
        //   ),
        //   isSender: false,
        // ),