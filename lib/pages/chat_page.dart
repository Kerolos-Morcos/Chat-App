import 'package:chat_app/constants.dart';
import 'package:chat_app/models/messages.dart';
import 'package:chat_app/widgets/custom_chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  static String id = 'chatPage';
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);
  TextEditingController controller = TextEditingController();

  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    Map<String?, String?> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String?, String?>;

    String passedUsername = arguments['username'] as String;
    String passedEmail = arguments['email'] as String;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kMessageTime, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            var doc = snapshot.data!.docs[i];
            var message = Message.fromJson(doc);
            message.username = doc['username']; // Add this line
            messagesList.add(message);

            WidgetsBinding.instance.addPostFrameCallback((_) {
              scrollController.animateTo(
                scrollController.position.extentTotal,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            });
          }
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
                    reverse: true,
                    controller: scrollController,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == passedEmail
                          ? CustomChatBubble(
                              message: messagesList[index],
                              username: '${messagesList[index].username}(You)',
                            )
                          : CustomChatBubbleForFriend(
                              messageBody: messagesList[index],
                              username: messagesList[index].username,
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
                          messages.add(
                            {
                              kMessageBody: controller.text,
                              kMessageTime: FieldValue.serverTimestamp(),
                              'id': passedEmail,
                              'username': passedUsername,
                            },
                          );
                          controller.clear();
                          // scrollController.animateTo(
                          //     scrollController.position.extentTotal,
                          //     // 0,
                          //     duration: const Duration(seconds: 3),
                          //     curve: Curves.fastOutSlowIn,
                          //   );
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
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
              backgroundColor: Colors.grey,
            ),
          );
        }
      },
    );
  }
}