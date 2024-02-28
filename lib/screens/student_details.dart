import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studentmanagement/utils/responsive/responsive_widget.dart';
import 'package:studentmanagement/widgets/mobile-widgets/student_detatils_page_mobile.dart';
import 'package:studentmanagement/widgets/desktop-widgets/desktop_screens/student_details_desktop.dart';

class StudentDetailsPage extends StatelessWidget {
  const StudentDetailsPage({super.key, required this.student});
  final DocumentSnapshot student;
  @override
  Widget build(BuildContext context) {
    return ResponiveLayout(
        desktop: StudentDetailDesktop(
          student: student,
        ),
        tablet: StudentDetailDesktop(
          student: student,
        ),
        mobile: StudenDetailMobile(student: student));
  }
}
