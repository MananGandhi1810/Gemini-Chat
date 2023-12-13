import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/chat_context_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: context.watch<ChatContextProvider>().messages.length,
              controller: scrollController,
              itemBuilder: (context, index) {
                if (context.watch<ChatContextProvider>().messages[index].role ==
                        'user' &&
                    index ==
                        context.watch<ChatContextProvider>().messages.length -
                            1) {
                  return Column(
                    children: [
                      BubbleNormal(
                        text: context
                            .watch<ChatContextProvider>()
                            .messages[index]
                            .text,
                        isSender: context
                                    .watch<ChatContextProvider>()
                                    .messages[index]
                                    .role ==
                                'user'
                            ? true
                            : false,
                        color: context
                                    .watch<ChatContextProvider>()
                                    .messages[index]
                                    .role ==
                                'user'
                            ? Colors.blue
                            : Colors.grey,
                      ),
                      BubbleNormal(
                        text: '...',
                        isSender: false,
                        color: Colors.grey,
                      )
                    ],
                  );
                }
                return BubbleNormal(
                  text:
                      context.watch<ChatContextProvider>().messages[index].text,
                  isSender: context
                              .watch<ChatContextProvider>()
                              .messages[index]
                              .role ==
                          'user'
                      ? true
                      : false,
                  color: context
                              .watch<ChatContextProvider>()
                              .messages[index]
                              .role ==
                          'user'
                      ? Colors.blue
                      : Colors.grey,
                );
              },
            ),
          ),
          TextField(
            controller: _messageController,
            decoration: InputDecoration(
              hintText: 'Type a message',
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  context
                      .read<ChatContextProvider>()
                      .getResponse(_messageController.text);
                  _messageController.clear();
                  scrollController.animateTo(
                    scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
