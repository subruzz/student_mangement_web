import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studentmanagement/screens/student_details.dart';

class MobileDisplayStudents extends StatelessWidget {
  const MobileDisplayStudents({Key? key, required this.student})
      : super(key: key);

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
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white, // Set background color
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Set shadow color
                  spreadRadius: 3, // Set spread radius
                  blurRadius: 5, // Set blur radius
                  offset:const  Offset(0, 4), // Set offset
                ),
              ],
            ),
            child: ListTile(
              onTap: () {
                StudentDetailsPage(student: studentSnap[index]);
              },
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: studentSnap['profilePicture'].isEmpty
                    ? const AssetImage('assets/images/profile.png')
                    : NetworkImage(studentSnap['profilePicture'])
                        as ImageProvider<Object>,
              ),
              title: Text(
                studentSnap['name'],
                maxLines: 2,
                style: Theme.of(context).textTheme.labelMedium,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                'batch:${studentSnap['batch']}',
                style: Theme.of(context).textTheme.labelSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                onPressed: () {
                  // Handle more options
                },
                icon: const Icon(Icons.more_vert_rounded),
              ),
            ),
          ),
        );
      },
    );
  }
}
