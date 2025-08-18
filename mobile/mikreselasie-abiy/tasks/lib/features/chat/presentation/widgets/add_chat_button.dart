import 'package:ecommerce/features/chat/presentation/bloc/chat/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddChatButton extends StatelessWidget {
  const AddChatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatsBloc, ChatsState>(
      listener: (context, state) {
        if (state is ChatsInitiateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Chat started successfully!')),
          );
        } else if (state is ChatsFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to start chat: ${state.message}')),
          );
        }
      },
      child: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog<Map<String, String>>(
            context: context,
            builder: (context) {
              final userIdController = TextEditingController();
              final messageController = TextEditingController();

              return AlertDialog(
                title: const Text('Start a new chat'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: userIdController,
                      decoration: const InputDecoration(labelText: 'User ID'),
                    ),
                    TextFormField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        labelText: 'Initial Message',
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Cancel
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (userIdController.text.isNotEmpty &&
                          messageController.text.isNotEmpty) {
                        Navigator.of(context).pop({
                          'userId': userIdController.text,
                          'message': messageController.text,
                        });
                      } else {
                        // Optionally show an error or do nothing
                      }
                    },
                    child: const Text('Start Chat'),
                  ),
                ],
              );
            },
          );

          if (result != null) {
            context.read<ChatsBloc>().add(
              InitiateChatRequested(
                userId: result['userId']!,
                initialMessage: result['message']!,
              ),
            );
          }
        },
        child: const Icon(Icons.chat),
      ),
    );
  }
}
