class UserModel {
  final String uid;
  final String email;
  final String userName;
  final DateTime createdAt;
  final int status;
  UserModel(
      {required this.uid,
      required this.userName,
      required this.email,
      required this.status,
      required this.createdAt});
  // factory UserModel.fromJson(DocumentSnapshot data) {
  //   return UserModel(
  //       id: data['uid'],
  //       userName: data['userName'],
  //       email: data['email'],
  //       status: data['status'],
  //       createdAt: data['createdAt']);
  // }
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'userName': userName,
      'email': email,
      'status': status,
      'createdAt': createdAt
    };
  }
}
