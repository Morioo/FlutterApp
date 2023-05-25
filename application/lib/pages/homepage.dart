import 'package:aplication/model/chat_bot.dart';
import 'package:aplication/model/conversation.dart';
import 'package:aplication/pages/chat_page.dart';
import 'package:aplication/pages/homepage.dart';
import 'package:aplication/provider/data.dart';
import 'package:aplication/widgets/conversation_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'homepage.dart';

// ignore: unused_import


class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    final data = context.read<Data>();
    final odwrotny = ChatBot(
      name: 'Odwrotny',
      getAnswer: (input) => input.split('').reversed.join(''),
    );
    final nic = ChatBot(
      name: 'Nic',
      getAnswer: (input) => input,
    );
    // ignore: invalid_null_aware_operator
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (data.conversations.isEmpty && data.bots.isEmpty) {
        data.addChatBotAndStartConverstaion(odwrotny);
        data.addChatBotAndStartConverstaion(nic);
      } else {
        data.loadChatBots([odwrotny, nic]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chats = context.watch<Data>().conversations;

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Czat boty'),
          ),
          body: ListView.separated(
              itemBuilder: (context, index) {
                return ConversationTile(
                    content: chats[index].messages.isEmpty ? '' : chats[index].messages.last.text,
                    timestamp: chats[index].messages.isEmpty
                        ? ''
                        : DateFormat.Hm().format(chats[index].messages.last.timestamp),
                    title: chats[index].chatBotName,
                    onTap: () => _navigateToChat(chats[index], index));
              },
              separatorBuilder: (context, index) => const Divider(
                    height: 1,
                    thickness: 1,
                  ),
              itemCount: chats.length)),
    );
  }

  void _navigateToChat(Conversation chat, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(
          id: chat.id,
        ),
      ),
    );
  }
}

class Hm {
}

class DateFormat {
  static Hm() {}
}
