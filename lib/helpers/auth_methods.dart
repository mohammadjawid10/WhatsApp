import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp/models/user.dart' as model;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp/helpers/storage_methods.dart';

class AuthMethods {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> signup({
    required String bio,
    required String email,
    required String fullName,
    required String password,
    required Uint8List file,
  }) async {
    String res = 'An Error Occurred';

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      log('Auth Methods - Signup : ${userCredential.user!.uid}');

      String imageUrl = await StorageMethods().uploadImageToStorage(file);

      /// Add user to the database
      model.User user = model.User(
        email: email,
        password: password,
        bio: bio,
        fullName: fullName,
        imageUrl: imageUrl,
        uid: userCredential.user!.uid,
        username: email.replaceAll('@gmail.com', ''),
      );

      // save user info in firestore database to later upload in profile
      firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(user.toJson());

      await auth.currentUser!.sendEmailVerification();

      res = 'success';
    } on FirebaseAuthException catch (e) {
      res = e.code;
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<String> login({
    required String email,
    required String password,
  }) async {
    String res = 'An Error Occurred';

    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      res = 'success';
    } on FirebaseAuthException catch (e) {
      res = e.code;
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<String> logout() async {
    String res = 'An Error Occurred';
    try {
      await auth.signOut();
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> verifyUser() async {
    final user = auth.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      return 'user does not exist.';
    }
    return 'success';
  }
}
