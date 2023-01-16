import 'dart:ui';

import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:chat_app/models/user.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final User user;
  ChatScreen({required this.user});
  @override
  State<ChatScreen> createState() => _ChatScreen();
}

class _ChatScreen extends State<ChatScreen> {
  TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.all(8.0),
            child: ClipOval(
              child: Image(
                image: NetworkImage(widget.user.imageUrl),
              ),
            ),
          ),
          title: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                    text: widget.user.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    )),
                TextSpan(text: '\n'),
                TextSpan(
                  text: 'Online',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ]))),
      body: Column(
        children: [
          Expanded(
            child: GroupedListView<Message, DateTime>(
              controller: _scrollController,
              padding: const EdgeInsets.all(8),
              elements: chats,
              groupBy: (message) => DateTime(
                message.time.year,
                message.time.month,
                message.time.day,
              ),
              groupHeaderBuilder: (Message message) => SizedBox(
                  height: 40,
                  child: Center(
                      child: Card(
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        DateFormat.yMMMd().format(message.time),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ))),
              itemBuilder: (context, Message message) => Align(
                alignment: message.isSentByMe
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: message.isSentByMe
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(message.text),
                      ),
                    ),
                    SizedBox(height: 5),
                    Align(
                      alignment: message.isSentByMe
                          ? Alignment.bottomRight
                          : Alignment.bottomLeft,
                      child: Text(DateFormat.Hm().format(message.time)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.grey.shade300,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      hintText: 'Type your message here...',
                    ),
                    controller: _textController,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  child: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      final text = _textController.text;

                      if (text.isNotEmpty) {
                        final message = Message(
                          sender: currentUser,
                          time: DateTime.now(),
                          text: text,
                          isSentByMe: true,
                        );
                        setState(() => chats.add(message));

                        _textController.clear();
                        _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeOut);
                      }
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
