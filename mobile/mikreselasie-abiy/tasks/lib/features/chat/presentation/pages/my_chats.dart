import 'package:ecommerce/features/chat/presentation/widgets/add_chat_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/presentation/routers/app_routes.dart';
import '../../../../core/presentation/widgets/snack_bar.dart';
import '../../domain/entities/chat.dart';
import '../bloc/chat/chat_bloc.dart';

class ChatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<ChatsBloc>().add(ChatsLoadRequested());

    return BlocListener<ChatsBloc, ChatsState>(
      listener: (context, state) {
        if (state is ChatsFailure) {
          showError(context, state.message);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF4D80F7),
        appBar: AppBar(
          backgroundColor: const Color(0xFF4D80F7),
          elevation: 0,
          title: const Text(
            'Chats',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(children: [_buildSearchBar(), _buildChatList()]),
        ),
        floatingActionButton: AddChatButton(),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(50),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.white70),
            const SizedBox(width: 8),
            const Expanded(
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search chats...',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatList() {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: BlocBuilder<ChatsBloc, ChatsState>(
          builder: (context, state) {
            if (state is ChatsLoadInProgress) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFF4D80F7)),
              );
            }

            if (state is ChatsFailure) {
              return _buildErrorState(context, state.message);
            }

            final chats = state.chats;

            if (chats.isEmpty) {
              return _buildEmptyState();
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<ChatsBloc>().add(ChatsLoadRequested());
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  return _buildChatItem(context, chats[index]);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            'Failed to load chats',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<ChatsBloc>().add(ChatsLoadRequested());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4D80F7),
              foregroundColor: Colors.white,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            'No chats yet',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            'Start a conversation with someone!',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildChatItem(BuildContext context, Chat chat) {
    final chatPartner = chat.user2;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: const Color(0xFF4D80F7),
          child: Text(
            chatPartner.name.isNotEmpty
                ? chatPartner.name[0].toUpperCase()
                : '?',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          chatPartner.name,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        subtitle: Text(
          'Tap to start chatting',
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Now',
              style: TextStyle(color: Colors.grey[500], fontSize: 12),
            ),
          ],
        ),
        onTap: () {
          context.go(Routes.chatInbox, extra: chat);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: Colors.grey[50],
      ),
    );
  }
}
