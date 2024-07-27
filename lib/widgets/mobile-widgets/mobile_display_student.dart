import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studentmanagement/screens/add_student.dart';
import 'package:studentmanagement/screens/student_details.dart';
import 'package:studentmanagement/services/student_services.dart';
import 'package:studentmanagement/widgets/helping-widgets/dialog.dart';

class MobileDisplayStudents extends StatelessWidget {
  const MobileDisplayStudents({super.key, required this.student});

  final List<DocumentSnapshot> student;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: student.length,
      itemBuilder: (context, index) {
        final DocumentSnapshot studentSnap = student[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Dismissible(
            direction: DismissDirection.endToStart,
            key: ValueKey(studentSnap.id),
            background: Container(
              color: Colors.red,
              child: const Icon(
                Icons.delete,
                color: Colors.white,
                size: 36,
              ),
            ),
            confirmDismiss: (direction) {
              return showDialog(
                context: context,
                builder: (ctx) => CustomDialog(
                  title: 'Are you sure you want to delete this student?',
                  onClick: () {
                    StudentServices.deleteStudent(student[index].id);
                  },
                ),
              );
            },
            child: Card(
              elevation: 5,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) =>
                              StudentDetailsPage(student: studentSnap)));
                },
                contentPadding: const EdgeInsets.all(0),
                leading: studentSnap['profilePicture'].isEmpty
                    ? const CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            AssetImage('assets/images/profile.png'),
                      )
                    : CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            NetworkImage(studentSnap['profilePicture']),
                      ),
                title: Text(
                  studentSnap['name'],
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                subtitle: Text(
                  studentSnap['batch'],
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(color: Colors.grey),
                ),
                trailing: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => AddDetails(
                                  studentId: studentSnap.id,
                                  student: studentSnap)));
                    },
                    icon: const Icon(Icons.edit)),
              ),
            ),
          ),
        );
      },
    );
  }
}
