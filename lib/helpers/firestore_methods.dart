import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreMethods {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //! Add user info to firebase when you create an account
  Future addUserToFirebase(Map<String, dynamic> userInfo, String uid) async {
    return await firestore.collection('users').doc(uid).set(userInfo);
  }

  Future<Stream<QuerySnapshot>> getUserbyUsername(String username) async {
    return firestore
        .collection('users')
        .where('username', isEqualTo: username)
        .snapshots();
  }

  createChatRoom({
    required String chatRoomId,
    required Map<String, dynamic> chatRoomInfo,
  }) async {
    final snapshot =
        await firestore.collection('chatrooms').doc(chatRoomId).get();

    if (snapshot.exists) {
      // We already have a chatroom. no need to create anything.
      return true;
    } else {
      // chatroom doesn't exist so we need to create one

      return firestore
          .collection('chatrooms')
          .doc(chatRoomId)
          .set(chatRoomInfo);
    }
  }

  Future sendMessage({
    required String chatRoomId,
    required String messageId,
    required Map<String, dynamic> messageInfo,
  }) async {
    await firestore
        .collection('chatrooms')
        .doc(chatRoomId)
        .collection('chats')
        .doc(messageId)
        .set(messageInfo);
  }

  updateLastMessage({
    required String chatRoomId,
    required Map<String, dynamic> lastMessageInfo,
  }) async {
    await firestore
        .collection('chatrooms')
        .doc(chatRoomId)
        .update(lastMessageInfo);
  }
}
