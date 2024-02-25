import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studentmanagement/models/student_details.dart';
import 'package:studentmanagement/utils/storage_methods.dart';
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
      required DateTime dob,
      required int number,
      required Uint8List? profilePic}) async {
    try {
      String imgUrl = '';
      if (profilePic != null) {
        imgUrl = await StorageMethod.uploadImageToStorage(
          'profileImage',
          profilePic,
        );
      }
      String studentId = const Uuid().v1();
      final student = StudentDetails(
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
          dob: dob);
      await students.doc(studentId).set(student.toJson());
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
