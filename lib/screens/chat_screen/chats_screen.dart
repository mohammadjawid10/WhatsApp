import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:whatsapp/models/chat.dart';

import 'package:whatsapp/screens/screens.dart';
import 'package:whatsapp/widgets/chat_screen/chat_list_item.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myUserName =
        FirebaseAuth.instance.currentUser!.email!.replaceAll('@gmail.com', '');

    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chatrooms')
            .where('members', arrayContains: myUserName)
            .snapshots(),
        builder: (
          context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
        ) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final item = snapshot.data!.docs[index];
                final username = (item['members'] as List).firstWhere(
                  (username) => username != myUserName,
                );

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ChatListItem(
                    item: Chat(
                      title: item['chatRoomId'],
                      date: Jiffy(item['lastMessageTs'].toDate()).Hm,
                      imageUrl:
                          'https://th.bing.com/th/id/R.86ddf59f73f9ad652fa8d5aa4b91803b?rik=FkmJyBJWUlailg&pid=ImgRaw&r=0',
                      lastMessage: item['lastMessage'],
                    ),
                    chatRoomId: item['chatRoomId'],
                    username: username,
                    imageUrl:
                        'https://th.bing.com/th/id/R.86ddf59f73f9ad652fa8d5aa4b91803b?rik=FkmJyBJWUlailg&pid=ImgRaw&r=0',
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff00A884),
        onPressed: () {
          Navigator.of(context).pushNamed(AddChatScreen.routeName);
        },
        child: const Icon(Icons.message),
      ),
    );
  }
}
