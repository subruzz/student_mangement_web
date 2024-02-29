import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:studentmanagement/models/student_details.dart';
import 'package:studentmanagement/services/storage_service.dart';
import 'package:uuid/uuid.dart';

class StudentServices {
  static String res = 'some error occured';
  static final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  static final CollectionReference students =
      FirebaseFirestore.instance.collection('studentCollection');
  static Future<String> addStuent(
      {required String studenName,
      required String parentName,
      required String batch,
      required int age,
      required String uid,
      required String address,
      required String email,
      required int number,
      required Uint8List? profilePic}) async {
    String studentId = const Uuid().v1();

    try {
      String imgUrl = '';
      if (profilePic != null) {
        imgUrl = await StorageMethod.uploadImageToStorage(
            'profileImage', profilePic, studentId);
      }
      final student = StudentDetails(
        timeStamp: Timestamp.now(),
        uid: uid,
        sid: studentId,
        parentName: parentName,
        name: studenName,
        age: age,
        batch: batch,
        address: address,
        contactNumber: number,
        emailAddress: email,
        profilePicture: imgUrl,
      );
      await students.doc(studentId).set(student.toJson());
      res = 'successfully added student';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  static Future<String> updateStudent(
      {required String studenName,
      required String? currentProfile,
      required String parentName,
      required String batch,
      required int age,
      required String uid,
      required String address,
      required String email,
      required Timestamp timestamp,
      required int number,
      required String sid,
      required Uint8List? profilePic}) async {
    try {
      String imgUrl = '';
      if (profilePic != null) {
        imgUrl = await StorageMethod.uploadImageToStorage(
            'profileImage', profilePic, sid);
      }
      final student = StudentDetails(
        timeStamp: timestamp,
        uid: uid,
        sid: sid,
        parentName: parentName,
        name: studenName,
        age: age,
        batch: batch,
        address: address,
        contactNumber: number,
        emailAddress: email,
        profilePicture: imgUrl.isEmpty ? currentProfile : imgUrl,
      );
      students.doc(sid).update(student.toJson());
      await students.doc(sid).set(student.toJson());
      res = 'updated student details';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  static Future deleteStudent(String id) async {
    await students.doc(id).delete();
    await StorageMethod.deleteImageFromStorage(
        FirebaseAuth.instance.currentUser!.uid, id);
  }
}
