class Chat {
  final String title;
  final String date;
  final String lastMessage;
  final int unreadMessage;
  final String imageUrl;

  Chat({
    required this.title,
    required this.date,
    required this.lastMessage,
    this.unreadMessage = 0,
    required this.imageUrl,
  });
}
