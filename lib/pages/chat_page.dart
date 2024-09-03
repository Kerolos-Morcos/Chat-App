import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/chat/chat_cubit.dart';
import 'package:chat_app/widgets/custom_app_bar.dart';
import 'package:chat_app/widgets/custom_chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});
  static String id = 'chatPage';

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    Map<String?, String?> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String?, String?>;

    String passedUsername = arguments['username'] as String;
    String passedEmail = arguments['email'] as String;
    var controller = BlocProvider.of<ChatCubit>(context).controller;
    var messagesList = BlocProvider.of<ChatCubit>(context).messagesList;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 229, 229),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.092,
        ),
        child: const CustomAppBar(),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                return ListView.builder(
                  reverse: true,
                  controller: scrollController,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    return messagesList[index].id == passedEmail
                        ? CustomChatBubble(
                            message: messagesList[index],
                            username:
                                messagesList[index].username.contains("(You)")
                                    ? messagesList[index].username
                                    : '${messagesList[index].username} (You)',
                          )
                        : CustomChatBubbleForFriend(
                            messageBody: messagesList[index],
                            username: messagesList[index].username,
                          );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Send Message ...',
                hintStyle: TextStyle(
                  color: Colors.grey.shade600,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    BlocProvider.of<ChatCubit>(context).sendMessage(
                      message: controller.text,
                      email: passedEmail,
                      username: passedUsername,
                    );
                    scrollController.animateTo(0,
                        duration: const Duration(seconds: 1),
                        curve: Curves.fastOutSlowIn);
                  },
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
