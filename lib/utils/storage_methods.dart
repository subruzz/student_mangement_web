// import 'dart:typed_data';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// class StorageMethod {
//   static final FirebaseStorage storage = FirebaseStorage.instance;
//   static final FirebaseAuth auth = FirebaseAuth.instance;
//   Future<String> uploadImageToStorage(String childName, Uint8List file) async {
//     Reference ref = storage.ref().child(childName).child(auth.currentUser!.uid);
//     UploadTask task = ref.putData(file);
//     TaskSnapshot snap=await  task;
//   }
// }
