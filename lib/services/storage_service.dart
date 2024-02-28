import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class StorageMethod {
  static final FirebaseStorage storage = FirebaseStorage.instance;
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static Future<String> uploadImageToStorage(
      String childName, Uint8List file) async {
    String id = const Uuid().v1();
    Reference ref =
        storage.ref().child(childName).child(auth.currentUser!.uid).child(id);
    UploadTask task =
        ref.putData(file, SettableMetadata(contentType: 'image/jpeg'));
    TaskSnapshot snap = await task;
    String downloadURl = await snap.ref.getDownloadURL();
    return downloadURl;
  }

  static Future<void> deleteImageFromStorage(String imagePath) async {
    final Reference storageRef =
        FirebaseStorage.instance.ref().child('StudentImages').child(imagePath);

    try {
      await storageRef.delete();
      debugPrint('Image deleted from Firebase Storage');
    } catch (e) {
      debugPrint('Error deleting image from Firebase Storage: $e');
    }
  }
}
