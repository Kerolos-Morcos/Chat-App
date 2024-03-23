import 'package:chat_app/constants.dart';
import 'package:chat_app/models/messages.dart';
import 'package:chat_app/widgets/custom_chat_bubble.dart';
import 'package:flutter/material.dart';
// import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  static String id = 'chatPage';
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);
  TextEditingController controller = TextEditingController();

  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
  var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages
          // .orderBy(kMessageDocumentCreatedAt, descending: true)
          // .snapshots(),
         .orderBy(kMessageDocumentCreatedAt)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
        // if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(
              Message.fromJson(
                snapshot.data!.docs[i].data(),
              ),
            );
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
                    // reverse: true,
                    controller: scrollController,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email ? CustomChatBubble(
                        message: messagesList[index]
                      ) : CustomChatBubbleForFriend(message: messagesList[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: controller,
                    // onSubmitted: (value) {
                    //   messages.add(
                    //     {
                    //       'body': value,
                    //       'date': DateTime.now(),
                    //     },
                    //   );
                    //   controller.clear();
                    // },
                    decoration: InputDecoration(
                      hintText: 'Send Message',
                      suffixIcon: IconButton(
                        onPressed: () {
                          messages.add(
                            {
                              kMessageDocumentBody: controller.text,
                              kMessageDocumentCreatedAt: FieldValue.serverTimestamp(),
                              kUserID: email,
                            },
                          );
                          controller.clear();
                          // scrollController.animateTo(
                          //     scrollController.position.extentTotal,
                          //     // 0,
                          //     duration: const Duration(seconds: 3),
                          //     curve: Curves.fastOutSlowIn,
                          //   );
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