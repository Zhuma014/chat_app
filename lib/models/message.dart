import './user.dart';

class Message {
  final User sender;
  final DateTime time;
  final String text;
  final bool isSentByMe;

  const Message({
    required this.sender,
    required this.time,
    required this.text,
    required this.isSentByMe,
  });
}

List<Message> chats = [
  Message(
    sender: Zhuma,
    time: DateTime.now().subtract(Duration(minutes: 1)),
    text: 'Hello teacher',
    isSentByMe: false,
  ),
];
