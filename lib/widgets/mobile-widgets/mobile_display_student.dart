import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studentmanagement/screens/student_detatils_page.dart';

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
          child: ListTile(
            
            contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              side: BorderSide(color: Colors.grey.shade300), // Border color
            ),
            tileColor: Colors.white, // Background color
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
              icon: Icon(Icons.more_vert_rounded),
            ),
          ),
        );
      },
    );
  }
}
