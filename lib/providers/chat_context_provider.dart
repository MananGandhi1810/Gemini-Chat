import 'package:flutter/foundation.dart';

import '../models/chat_message_model.dart';
import '../repositories/chat_repository.dart';

class ChatContextProvider extends ChangeNotifier {
  final List<ChatMessageModel> _messages = [];
  final ChatRepository chatRepository = ChatRepository();

  List<ChatMessageModel> get messages => _messages;

  void getResponse(String message) async {
    _messages.add(
      ChatMessageModel(
        text: message,
        role: 'user',
      ),
    );
    notifyListeners();
    final context = _messages.map((e) => e.toJson()).toList();
    debugPrint(context.toString());
    final response = await chatRepository.generateContent(context);
    _messages.add(
      ChatMessageModel(
        text: response,
        role: 'model',
      ),
    );
    debugPrint(response);
    notifyListeners();
  }
}