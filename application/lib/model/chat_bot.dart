typedef Answer = String Function(String input);

class ChatBot {
  ChatBot({required this.name, required this.getAnswer});

  final String name;
  final Answer getAnswer;
}
