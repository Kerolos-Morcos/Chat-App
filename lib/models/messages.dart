import 'package:chat_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String body;
  final DateTime createdAt;
  final String id;
  String username;
  Message({
    required this.id,
    required this.createdAt,
    required this.body,
    required this.username,
  });

  factory Message.fromJson(jsonData) {
    return Message(
      body: jsonData[kMessageBody],
      createdAt: jsonData['createdAt'] != null
        ? (jsonData['createdAt'] as Timestamp).toDate()
        : DateTime.now(),
      id: jsonData[kUserID],
      username:  jsonData['username'],
    );
  }
}
