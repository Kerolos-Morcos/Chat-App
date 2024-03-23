import 'package:chat_app/constants.dart';

class Message {
  final String body;
  // final String userName;
  final String id;
  Message(this.body, this.id);
  factory Message.fromJson(json) {
    return Message(
      json[kMessageDocumentBody],
      // json['userName'],
      json[kUserID],
    );
  }
}
