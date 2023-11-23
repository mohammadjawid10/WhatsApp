class ChatRoom {
  final List members;
  final String roomId;
  final String roomUrl;
  final String lastMessage;
  final DateTime lastMessageTs;
  final String roomName;

  ChatRoom({
    required this.members,
    required this.roomId,
    required this.roomUrl,
    required this.lastMessage,
    required this.lastMessageTs,
    required this.roomName,
  });
}
