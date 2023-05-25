import 'dart:convert';

import 'package:aplication/model/conversation.dart';
import 'package:aplication/pages/data_loading_page.dart';
import 'package:aplication/provider/data.dart';
import 'package:aplication/widgets/bubble.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ChatPage extends StatefulWidget {
  const ChatPage({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Data data = context.watch<Data>();
    List chats = data.conversations;
    final chat = chats.firstWhere((element) => element.id == widget.id);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(chat.chatBotName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: chat.messages.length,
                  itemBuilder: (context, index) {
                    final message = chat.messages[index];
                    var DateFormat;
                    return Bubble(
                      isWrittenByHuman: message.isWrittenByHuman,
                      timestamp: DateFormat.Hm().format(message.timestamp),
                      message: message.text,
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      maxLines: null,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          hintText: 'Napisz wiadomość',
                          contentPadding: const EdgeInsets.all(16)),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  IconButton(icon: const Icon(Icons.send), onPressed: () => _sendMessage(data)),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  void _sendMessage(Data data) {
    print('TEST: ${controller.text}');
    data.addMessage(widget.id, controller.text);
    controller.clear();
    Future.delayed(const Duration(seconds: 5)).then((_) => _saveData());
  }

  void _saveData() async {
    if (mounted) {
      var SharedPreferences;
      final prefs = await SharedPreferences.getInstance();
      // ignore: use_build_context_synchronously
      final data = context.read<Data>().conversations;
      prefs.setStringList(dataKey, data.map((e) => jsonEncode(e)).toList());
    }
  }
}
