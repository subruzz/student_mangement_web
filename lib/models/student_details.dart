import 'package:cloud_firestore/cloud_firestore.dart';

class StudentDetails {
  final String uid;
  final String sid;
  final String name;
  final int age;
  final String batch;
  final String address;
  final int contactNumber;
  final String emailAddress;
  final String? profilePicture;
  final String parentName;
  final Timestamp timeStamp;

  StudentDetails({
    required this.uid,
    required this.timeStamp,
    required this.sid,
    required this.parentName,
    required this.name,
    required this.age,
    required this.batch,
    required this.address,
    required this.contactNumber,
    required this.emailAddress,
    required this.profilePicture,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'tid':uid,
      'age': age,
      'batch': batch,
      'parentName': parentName,
      'address': address,
      'timeStamp': timeStamp,
      'contactNumber': contactNumber,
      'emailAddress': emailAddress,
      'profilePicture': profilePicture,
    };
  }
}
