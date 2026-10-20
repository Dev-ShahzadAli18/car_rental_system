class ChatContactModel {
  final String id;
  final String name;
  final String avatarUrl;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isOnline;

  const ChatContactModel({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
    this.isOnline = false,
  });
}

class ChatMessage {
  final String id;
  final String text;
  final String time;
  final bool isMe;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.time,
    required this.isMe,
  });
}

final List<ChatContactModel> mockContacts = [
  const ChatContactModel(
    id: '1',
    name: 'Hela Quintin',
    avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=400&q=80',
    lastMessage: 'Your car is on the way! It will arrive...',
    time: '09:20 am',
    unreadCount: 2,
    isOnline: true,
  ),
  const ChatContactModel(
    id: '2',
    name: 'Cameron',
    avatarUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=400&q=80',
    lastMessage: 'Ok, thanks!',
    time: '09:20 am',
    unreadCount: 1,
    isOnline: true,
  ),
  const ChatContactModel(
    id: '3',
    name: 'Mr. Davit',
    avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=400&q=80',
    lastMessage: 'Thank you for booking with us! ......',
    time: '08:30 am',
    unreadCount: 0,
    isOnline: true,
  ),
  const ChatContactModel(
    id: '4',
    name: 'Richard',
    avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=400&q=80',
    lastMessage: 'You: A voice message',
    time: '07:32 am',
    unreadCount: 0,
    isOnline: false,
  ),
  const ChatContactModel(
    id: '5',
    name: 'Maichel',
    avatarUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=400&q=80',
    lastMessage: 'You: It was an amazing and smooth .....',
    time: 'Yesterday',
    unreadCount: 0,
    isOnline: false,
  ),
  const ChatContactModel(
    id: '6',
    name: 'Anna',
    avatarUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=400&q=80',
    lastMessage: "It's Ok, thankyou",
    time: 'Yesterday',
    unreadCount: 0,
    isOnline: true,
  ),
];
