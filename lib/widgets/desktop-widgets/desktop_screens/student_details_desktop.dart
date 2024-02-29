import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studentmanagement/screens/add_student.dart';
import 'package:studentmanagement/services/student_services.dart';
import 'package:studentmanagement/widgets/desktop-widgets/components/student_name_card.dart';
import 'package:studentmanagement/widgets/desktop-widgets/components/student_personal_card.dart';
import 'package:studentmanagement/widgets/helping-widgets/dialog.dart';
import 'package:studentmanagement/widgets/helping-widgets/student_detail_image.dart';

class StudentDetailDesktop extends StatefulWidget {
  const StudentDetailDesktop({
    super.key,
    required this.student,
  });
  final DocumentSnapshot student;

  @override
  State<StudentDetailDesktop> createState() => _DetailedStudetntState();
}

class _DetailedStudetntState extends State<StudentDetailDesktop> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => AddDetails(
                              studentId: widget.student.id,
                              student: widget.student))));
                },
                icon: const Icon(Icons.edit)),
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => CustomDialog(
                      title: 'Are you sure you want to delete this student?',
                      onClick: () {
                        StudentServices.deleteStudent(widget.student.id)
                            .then((value) => Navigator.pop(context));
                      },
                    ),
                  );
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ))
          ],
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text(
            'Student Details',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 41, 116, 176),
        ),
        body: Row(
          children: [
            StudentImage(image: widget.student['profilePicture']),
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    StudentContact(
                        batch: widget.student['batch'],
                        contact: widget.student['contactNumber'].toString(),
                        email: widget.student['emailAddress'],
                        name: widget.student['name']),
                    const Divider(),
                    StudentPersonalCard(
                        address: widget.student['address'],
                        age: widget.student['age'].toString(),
                        parent: widget.student['parentName']),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
