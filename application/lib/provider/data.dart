import 'package:aplication/model/chat_bot.dart';
import 'package:aplication/model/conversation.dart';
import 'package:aplication/model/message.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Data with ChangeNotifier, DiagnosticableTreeMixin {
  List<Conversation> _conversations = [];
  List<ChatBot> _bots = [];

  List<Conversation> get conversations => _conversations;
  List<ChatBot> get bots => _bots;

  ChatBot _getBotByName(String name) {
    return _bots.firstWhere((element) => element.name == name);
  }

  void addChatBotAndStartConverstaion(ChatBot chatBot) {
    _bots.add(chatBot);
    _conversations.add(
      Conversation(
        id: '${chatBot.name}-${_conversations.length}',
        chatBotName: chatBot.name,
      ),
    );
    notifyListeners();
  }

  void loadChatBots(List<ChatBot> bots) {
    _bots = bots;
    notifyListeners();
  }

  void loadConversations(List<Conversation> conversations) {
    _conversations = conversations;
    notifyListeners();
  }

  void addMessage(String id, String message) {
    final Conversation conversation = _conversations.firstWhere((c) => c.id == id);
    conversation.addMessage(Message(
      isWrittenByHuman: true,
      text: message,
      timestamp: DateTime.now(),
    ));
    notifyListeners();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      final conversation = _conversations.firstWhere((c) => c.id == id);
      conversation.addMessage(
        Message(
          isWrittenByHuman: false,
          text: _getBotByName(conversation.chatBotName).getAnswer(message),
          timestamp: DateTime.now(),
        ),
      );
      notifyListeners();
    });
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('bots', bots));
    properties.add(IterableProperty('conversations', conversations));
  }
}
