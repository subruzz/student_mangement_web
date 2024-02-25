import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:studentmanagement/models/user_model.dart';

class AuthServices {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('userCollection');

  static String res = 'some error';
  static Future<String> signupUser({
    required String email,
    required String password,
    required String username,
    required DateTime createdAt,
    required int status,
  }) async {
    try {
      UserCredential userData = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
//add user to collections
      UserModel user = UserModel(
          uid: userData.user!.uid,
          userName: username,
          email: email,
          status: status,
          createdAt: createdAt);
      await _userCollection.doc(userData.user!.uid).set(user.toJson());
      res = 'success';
    } on FirebaseException catch (err) {
      res = err.toString();
    }
    return res;
  }

  static Future<String> loginUser(
      {required String email, required String password}) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      }
    } on FirebaseException catch (err) {
      res = err.toString();
    }
    return res;
  }
  
}
