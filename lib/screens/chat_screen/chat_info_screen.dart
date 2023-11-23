

import 'package:flutter/material.dart';
import 'package:whatsapp/helpers/firestore_methods.dart';
import 'package:whatsapp/models/chat.dart';
import 'package:whatsapp/widgets/widgets.dart';
import 'package:whatsapp/constants/constants.dart';

Stream? usersStream;

class ChatInfoScreen extends StatefulWidget {
  const ChatInfoScreen({Key? key, required this.username}) : super(key: key);

  final String username;

  static const routeName = '/chat_info';

  @override
  State<ChatInfoScreen> createState() => _ChatInfoScreenState();
}

class _ChatInfoScreenState extends State<ChatInfoScreen> {
  getUser() async {
    usersStream = await FirestoreMethods().getUserbyUsername(widget.username);
  }

  loadOnLaunch() async {
    await getUser();
    setState(() {});
  }

  @override
  void initState() {
    loadOnLaunch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FA),
      body: StreamBuilder(
        stream: usersStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data.docs[0];

            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //! Chat Info Screen Header Widget
                    ChatInfoHeader(
                      chat: Chat(
                        imageUrl: snap['imageUrl'],
                        title: snap['fullName'],
                        date: 'Date',
                        lastMessage: snap[
                            'email'], // here i sent fake last message that is actually my email
                      ),
                    ),
                    //! ------------------------------
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        top: 20,
                        bottom: 10,
                        left: 15,
                        right: 15,
                      ),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snap['bio'],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          const Text(
                            'November 24, 2022',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              buildHorizontalIconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.notifications,
                                  color: buttonGreyColor,
                                ),
                                label: const Text(
                                  'Mute notifications',
                                  style: chatInfoScreenButtonTextStyle,
                                ),
                              ),
                              const Spacer(),
                              const MuteNotificationsSwitch(),
                            ],
                          ),
                          buildHorizontalIconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.audiotrack,
                              color: buttonGreyColor,
                            ),
                            label: const Text(
                              'Custom notifications',
                              style: chatInfoScreenButtonTextStyle,
                            ),
                          ),
                          buildHorizontalIconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.photo,
                              color: buttonGreyColor,
                            ),
                            label: const Text(
                              'Media Visibility',
                              style: chatInfoScreenButtonTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Column(
                        children: [
                          buildHorizontalIconButton(
                            label: const Text(
                              'Encryption',
                              style: chatInfoScreenButtonTextStyle,
                            ),
                            icon: const Icon(
                              Icons.lock,
                              color: buttonGreyColor,
                            ),
                            subtitle:
                                const Text('Messages and calls are end-to-end'),
                            onPressed: () {},
                          ),
                          buildHorizontalIconButton(
                            label: const Text(
                              'Disappearing messages',
                              style: chatInfoScreenButtonTextStyle,
                            ),
                            icon: const Icon(
                              Icons.timer,
                              color: buttonGreyColor,
                            ),
                            subtitle: const Text('Off'),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      color: Colors.white,
                      child: Column(
                        children: [
                          buildHorizontalIconButton(
                            label: Text(
                              'Block ${snap['fullName']}',
                              style: chatInfoScreenButtonTextStyleRed,
                            ),
                            icon: const Icon(
                              Icons.block,
                              color: Color(0xffEA0038),
                            ),
                            onPressed: () {},
                          ),
                          buildHorizontalIconButton(
                            label: Text(
                              'Report ${snap['fullName']}',
                              style: chatInfoScreenButtonTextStyleRed,
                            ),
                            icon: const Icon(
                              Icons.thumb_down,
                              color: Color(0xffEA0038),
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
} //! The last closing parenthesis
