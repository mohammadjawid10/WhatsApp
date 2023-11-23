import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp/helpers/firestore_methods.dart';

import 'package:whatsapp/models/models.dart';
import 'package:whatsapp/screens/screens.dart';
import 'package:whatsapp/widgets/widgets.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({
    Key? key,
    required this.username,
    required this.fullName,
    required this.chatRoomId,
    required this.imageUrl,
  }) : super(key: key);

  final String username;
  final String fullName;
  final String imageUrl;
  final String chatRoomId;

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();

  String myUserName = '';

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }

  sendMessage() async {
    final lastMessage = _messageController.text.trim();
    setState(() {
      _messageController.text = '';
    });

    final messageId = const Uuid().v1();
    final lastMessageTs = DateTime.now();

    Map<String, dynamic> messageInfo = {
      'text': lastMessage,
      'lastMessageTs': lastMessageTs,
      'sender': myUserName,
    };

    await FirestoreMethods()
        .sendMessage(
      chatRoomId: widget.chatRoomId,
      messageId: messageId,
      messageInfo: messageInfo,
    )
        .then(
      (value) {
        Map<String, dynamic> lastMessageInfo = {
          'lastMessage': lastMessage,
          'lastMessageTs': lastMessageTs,
        };

        FirestoreMethods().updateLastMessage(
          chatRoomId: widget.chatRoomId,
          lastMessageInfo: lastMessageInfo,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    myUserName =
        FirebaseAuth.instance.currentUser!.email!.replaceAll('@gmail.com', '');

    return Scaffold(
      backgroundColor: const Color(0xffECE6E0),
      appBar: AppBar(
        titleSpacing: 0,
        leadingWidth: 35,
        title: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ChatInfoScreen(
                  username: widget.username,
                ),
              ),
            );
          },
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.imageUrl),
              ),
              const SizedBox(width: 5),
              Text(widget.fullName),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chatrooms')
            .doc(widget.chatRoomId)
            .collection('chats')
            .orderBy('lastMessageTs', descending: false)
            .snapshots(),
        builder: (
          context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              final chat = snapshot.data?.docs[index];
              final message = Message(
                text: chat!['text'],
                date: chat['lastMessageTs'].toDate(),
                // imageUrl: '',
                sender: chat['sender'],
              );
              return Row(
                mainAxisAlignment: chat['sender'] != myUserName
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.end,
                children: [
                  const SizedBox.shrink(),
                  Flexible(
                    child: chat['sender'] == myUserName
                        ? SentMessage(message: message)
                        : ReceivedMessage(message: message),
                  ),
                ],
              );
            },
          );
        },
      ),
      bottomSheet: Container(
        color: const Color(0xffECE6E0),
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  child: Row(
                    children: [
                      buildMoodButton(),
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: const InputDecoration(
                            hintText: 'Message',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      buildAttachFileButton(),
                      buildCameraButton(),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 5),
              buildVoiceButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMoodButton() {
    return IconButton(
      onPressed: () {
        log('Show Stickers');
      },
      icon: const Icon(Icons.mood, color: Colors.grey),
    );
  }

  Widget buildAttachFileButton() {
    return Transform.rotate(
      angle: 45,
      child: IconButton(
        onPressed: () {
          log('Attach media');
        },
        icon: const Icon(Icons.attachment, color: Colors.grey),
      ),
    );
  }

  Widget buildCameraButton() {
    return IconButton(
      onPressed: () {
        log('Open camera');
      },
      icon: const Icon(Icons.photo_camera, color: Colors.grey),
    );
  }

  Widget buildVoiceButton() {
    return GestureDetector(
      onTap: sendMessage,
      child: const CircleAvatar(
        radius: 25,
        backgroundColor: Color(0xFF00BFA5),
        child: Icon(
          Icons.send,
          color: Colors.white,
          size: 25,
        ),
      ),
    );
  }
}
