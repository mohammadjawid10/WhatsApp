import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/constants/constants.dart';
import 'package:whatsapp/delegates/add_contacts_search_delegate.dart';
import 'package:whatsapp/helpers/firestore_methods.dart';
import 'package:whatsapp/screens/chat_screen/chat_detail_screen.dart';

class AddChatScreen extends StatelessWidget {
  static const routeName = '/add_chat';

  const AddChatScreen({Key? key}) : super(key: key);

  getChatRoomIdByUserNames(String me, String you) {
    if (me == you) {
      log('Empty -- Chat List Tile');
      return '';
    } else if (me.substring(0, 1).codeUnitAt(0) >
        you.substring(0, 1).codeUnitAt(0)) {
      log('$me-$you -- Chat List Tile');
      return '$me-$you';
    } else {
      log('$you-$me -- Chat List Tile');
      return '$you-$me';
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance.currentUser;
    final myUserName = auth!.email!.replaceAll('@gmail.com', '');

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .orderBy('username', descending: false)
          .where('username', isNotEqualTo: myUserName)
          .snapshots(),
      builder: (
        context,
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
      ) {
        if(snapshot.hasData) {
          return Scaffold(
          appBar: AppBar(
            backgroundColor: greenColor,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Select contact'),
                const SizedBox(height: 5),
                Text(
                  '${snapshot.data!.docs.length} contacts',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: AddContactSearchDelegate(),
                  );
                },
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
          body: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: ListTile(
                  contentPadding: EdgeInsets.only(top: 15, left: 15),
                  leading: CircleAvatar(
                    backgroundColor: brightGreenColor,
                    radius: 22,
                    child: Icon(Icons.group, color: Colors.white),
                  ),
                  title: Text(
                    'New group',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    const Expanded(
                      flex: 5,
                      child: ListTile(
                        contentPadding:
                            EdgeInsets.only(top: 15, left: 15, bottom: 5),
                        leading: CircleAvatar(
                          backgroundColor: brightGreenColor,
                          radius: 22,
                          child: Icon(Icons.person_add, color: Colors.white),
                        ),
                        title: Text(
                          'New contact',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.qr_code,
                          color: Color(0xff8696A0),
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data?.docs[index];

                    return ListTile(
                      onTap: () {
                        var chatRoomId = getChatRoomIdByUserNames(
                          myUserName,
                          data!['username'],
                        );

                        Map<String, dynamic> chatRoomInfo = {
                          'members': [myUserName, data['username']],
                          'lastMessage': '',
                          'lastMessageTs': DateTime.now(),
                          'chatRoomId': chatRoomId,
                        };

                        FirestoreMethods().createChatRoom(
                          chatRoomId: chatRoomId,
                          chatRoomInfo: chatRoomInfo,
                        );

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ChatDetailScreen(
                              username: data['username'],
                              fullName: data['fullName'],
                              imageUrl: data['imageUrl'],
                              chatRoomId: chatRoomId,
                            ),
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        radius: 22,
                        backgroundImage: NetworkImage(data!['imageUrl']),
                      ),
                      title: Text(
                        data['fullName'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(data['bio']),
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: ListTile(
                  contentPadding: const EdgeInsets.only(left: 25),
                  leading: const Icon(Icons.share,
                      size: 25, color: Color(0xff8696A0)),
                  title: const Text(
                    'Invite friends',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {},
                ),
              ),
              const SliverToBoxAdapter(
                child: ListTile(
                  contentPadding: EdgeInsets.only(
                    left: 25,
                  ),
                  leading: Icon(Icons.help, size: 25, color: Color(0xff8696A0)),
                  title: Text(
                    'Contacts help',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
        }

        return const Center(
          child: CircularProgressIndicator()
        );
       },
    );
  }

  Widget buildAddNewChatButton({
    required String title,
    required IconData icon,
  }) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: brightGreenColor,
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(width: 20),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}
