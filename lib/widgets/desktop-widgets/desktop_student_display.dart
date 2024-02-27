import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studentmanagement/responsive/add_student.dart';
import 'package:studentmanagement/screens/student_detatils_page.dart';
class DesktopDisplayStudents extends StatelessWidget {
  const DesktopDisplayStudents({super.key, required this.student});

  final List<DocumentSnapshot> student;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 400,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 2,
      ),
      itemCount: student.length,
      itemBuilder: (context, index) {
        final DocumentSnapshot studentSnap = student[index];
        return InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => DetailedStudetnt(student: studentSnap),
            ),
          ),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Picture Section
                  studentSnap['profilePicture'].isEmpty
                      ? const CircleAvatar(
                          radius: 45,
                          backgroundImage: AssetImage('assets/images/profile.png'),
                        )
                      : CircleAvatar(
                          radius: 45,
                          backgroundImage: NetworkImage(studentSnap['profilePicture']),
                        ),
                  const SizedBox(width: 20), // Spacer between image and text

                  // Details Section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          studentSnap['name'],
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          studentSnap['batch'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),

                  // Action Buttons Section
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => AddDetails(
                                student: studentSnap,
                                studentId: studentSnap.id,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          // deleteStudent(studentSnap.id);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
