import 'package:flutter/material.dart';

class ChatsPage extends StatelessWidget {
  final List<ChatUser> users = [
    ChatUser('Alex Linderson', 'How are you today?', 3, true, true),
    ChatUser('Team Align', 'Don’t miss to attend the meeting.', 4, true, false),
    ChatUser('John Ahraham', 'Hey! Can you join the meeting?', 0, false, false),
    ChatUser('Sabila Sayma', 'How are you today?', 0, false, false),
    ChatUser('John Borino', 'Have a good day 🌸', 0, true, false),
    ChatUser('Angel Dayna', 'How are you today?', 0, false, false),
  ];

  final List<StoryUser> stories = [
    StoryUser('My status', true),
    StoryUser('Adil', false),
    StoryUser('Marina', false),
    StoryUser('Dean', false),
    StoryUser('Max', false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4D80F7),
      body: SafeArea(
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.white70),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(color: Colors.white70),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Stories horizontal list
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: stories.length,
                itemBuilder: (context, index) {
                  final story = stories[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: story.isMyStatus
                                      ? Colors.white
                                      : Colors.amber,
                                  width: 3,
                                ),
                                gradient: story.isMyStatus
                                    ? null
                                    : LinearGradient(
                                        colors: [
                                          Colors.amber.shade300,
                                          Colors.amber.shade600,
                                        ],
                                      ),
                              ),
                              child: ClipOval(
                                child: Container(
                                  color: Colors.grey.shade300,
                                  child: Center(
                                    child: Text(
                                      story.name[0],
                                      style: TextStyle(
                                        fontSize: 28,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (story.isMyStatus)
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF4D80F7),
                                ),
                                child: Icon(
                                  Icons.add_circle,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          story.name,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Chats list container with white background and rounded top corners
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 16),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      leading: Stack(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.grey.shade300,
                            child: Text(
                              user.name[0],
                              style: TextStyle(
                                fontSize: 28,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 2,
                            right: 2,
                            child: CircleAvatar(
                              radius: 6,
                              backgroundColor: user.isOnline
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      title: Text(
                        user.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        user.lastMessage,
                        style: TextStyle(color: Colors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '2 min ago',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          if (user.unreadCount > 0)
                            Container(
                              margin: EdgeInsets.only(top: 6),
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFF4D80F7),
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '${user.unreadCount}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatUser {
  final String name;
  final String lastMessage;
  final int unreadCount;
  final bool isOnline;
  final bool isGroup;

  ChatUser(
    this.name,
    this.lastMessage,
    this.unreadCount,
    this.isOnline,
    this.isGroup,
  );
}

class StoryUser {
  final String name;
  final bool isMyStatus;

  StoryUser(this.name, this.isMyStatus);
}
