import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studentmanagement/screens/add_student.dart';
import 'package:studentmanagement/screens/student_details.dart';
import 'package:studentmanagement/services/student_services.dart';
import 'package:studentmanagement/widgets/helping-widgets/dialog.dart';

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
        childAspectRatio: 1.8,
      ),
      itemCount: student.length,
      itemBuilder: (context, index) {
        final DocumentSnapshot studentSnap = student[index];
        return InkWell(
            onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => StudentDetailsPage(student: studentSnap),
                  ),
                ),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Profile Picture Section
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        width: 90,
                        height: 90,
                        child: studentSnap['profilePicture'].isEmpty
                            ? Image.asset(
                                'assets/images/profile.png',
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                studentSnap['profilePicture'],
                                fit: BoxFit.cover,
                              ),
                      ),
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
                          const SizedBox(height: 6), // Add vertical spacing
                          Text(
                            studentSnap['batch'],
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.grey[600],
                                    ),                                    
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Spacer(),
                          Expanded(
                            child: Row(
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
                                  icon:const  Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => CustomDialog(
                                        title:
                                            'Are you sure you want to delete this student?',
                                        onClick: () {
                                          StudentServices.deleteStudent(
                                              student[index].id);
                                        },
                                      ),
                                    );
                                  },
                                  icon:const  Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
