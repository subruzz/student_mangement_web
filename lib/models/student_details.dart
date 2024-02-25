class StudentDetails {
  final int? id;
  final String name;
  final int age;
  final String batch;
  final String address;
  final int contactNumber;
  final String emailAddress;
  final String? profilePicture;
  final String parentName;
  final DateTime dob;

  StudentDetails({
    this.id,
    required this.parentName,
    required this.name,
    required this.age,
    required this.batch,
    required this.address,
    required this.contactNumber,
    required this.emailAddress,
    required this.profilePicture,
    required this.dob,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'batch': batch,
      'address': address,
      'contactNumber': contactNumber,
      'emailAddress': emailAddress,
      'dob': dob.toIso8601String(),
      'profilePicture': profilePicture,
    };
  }
}
