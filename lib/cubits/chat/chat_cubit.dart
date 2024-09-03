import 'dart:developer';

import 'package:chat_app/constants.dart';
import 'package:chat_app/models/messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial()) {
    getMessages();
  }

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);
  TextEditingController controller = TextEditingController();
  List<Message> messagesList = [];

  void sendMessage(
      {required message,
      required String email,
      required String username}) async {
    try {
      messages.add(
        {
          kMessageBody: message,
          kMessageTime: FieldValue.serverTimestamp(),
          'id': email,
          'username': username,
        },
      );
      controller.clear();
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  void getMessages() {
    messages
        .orderBy(kMessageTime, descending: true)
        .snapshots()
        .listen((event) {
      messagesList.clear();
      for (var doc in event.docs) {
        var message = Message.fromJson(doc);
        // message.username = doc['username'];
        messagesList.add(message);
      }
      emit(ChatSuccess(messagesList));
    });
  }
}
