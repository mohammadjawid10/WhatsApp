import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String imageUrl;
  final String username;
  final String fullName;
  final String bio;
  final String email;
  final String password;
  final String uid;

  User({
    required this.imageUrl,
    required this.username,
    required this.fullName,
    required this.bio,
    required this.email,
    required this.password,
    required this.uid,
  });

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'username': username,
      'fullName': fullName,
      'bio': bio,
      'email': email,
      'password': password,
      'uid': uid,
    };
  }

  static User fromSnapshot(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;
    return User(
      imageUrl: snap['imageUrl'],
      username: snap['usernmae'],
      fullName: snap['fullName'],
      bio: snap['bio'],
      email: snap['email'],
      password: snap['password'],
      uid: snap['uid'],
    );
  }
}
