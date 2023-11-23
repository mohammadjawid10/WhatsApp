import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //? Adding images to Firebase Storage
  Future<String> uploadImageToStorage(Uint8List file) async {
    final userId = _auth.currentUser!.uid;
    String imageId = const Uuid().v1();

    Reference ref = _storage.ref().child('profilePictures').child(userId).child(imageId);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
