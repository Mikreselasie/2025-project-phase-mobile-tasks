import 'package:ecommerce/features/chat/domain/entities/chat.dart';
import 'package:flutter/material.dart';



class ChatCard extends StatelessWidget {
  final Chat chat;
  final Function(Chat) onChatSelected;

  const ChatCard({super.key, required this.chat, required this.onChatSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChatSelected(chat);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('${chat.user1.name} <> ${chat.user2.name}'),
        ),
      ),
    );
  }
}
