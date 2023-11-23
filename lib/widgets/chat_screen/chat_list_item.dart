import 'package:flutter/material.dart';
import 'package:whatsapp/models/models.dart';
import 'package:whatsapp/screens/screens.dart';

class ChatListItem extends StatefulWidget {
  const ChatListItem({
    Key? key,
    required this.item,
    required this.chatRoomId,
    required this.username,
    required this.imageUrl,
  }) : super(key: key);

  final Chat item;
  final String chatRoomId;
  final String username;
  final String imageUrl;

  @override
  State<ChatListItem> createState() => _ChatListItemState();
}

class _ChatListItemState extends State<ChatListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChatDetailScreen(
              chatRoomId: widget.chatRoomId,
              fullName: widget.username,
              username: widget.username,
              imageUrl: widget.imageUrl,
            ),
          ),
        );
      },
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(widget.item.imageUrl),
      ),
      title: Text(widget.username),
      subtitle: Text(
        widget.item.lastMessage,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: SizedBox(
        child: SizedBox(
          width: 65,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                widget.item.date,
                style: TextStyle(
                  color: widget.item.unreadMessage == 0
                      ? Colors.black
                      : Colors.green,
                ),
              ),
              widget.item.unreadMessage == 0
                  ? const SizedBox.shrink()
                  : CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.green,
                      child: Text(
                        widget.item.unreadMessage.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
