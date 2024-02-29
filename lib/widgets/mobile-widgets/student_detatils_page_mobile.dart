import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studentmanagement/services/student_services.dart';
import 'package:studentmanagement/widgets/helping-widgets/dialog.dart';
import 'package:studentmanagement/widgets/helping-widgets/student_details_item.dart';

class StudenDetailMobile extends StatefulWidget {
  const StudenDetailMobile({
    super.key,
    required this.student,
  });
  final DocumentSnapshot student;

  @override
  State<StudenDetailMobile> createState() => _DetailedStudetntState();
}

class _DetailedStudetntState extends State<StudenDetailMobile> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 4,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 78, 129, 229),
                          Color.fromARGB(255, 80, 112, 167)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        children: [
                          widget.student['profilePicture'].isEmpty
                              ? ClipOval(
                                  child: Image.asset(
                                    'assets/images/profile.png',
                                    width: 100.0,
                                    height: 100.0,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : ClipOval(
                                  child: Image.network(
                                    widget.student['profilePicture'],
                                    width: 100.0,
                                    height: 100.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                          const SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(widget.student['name'],
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                Text(widget.student['batch'],
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    width: double.infinity,
                    child: const Row(
                      children: [
                        Icon(
                          Icons.contact_emergency,
                          size: 34,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Contact Details',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  StudentEachDetail(
                    title: 'e-mail:',
                    value: widget.student['emailAddress'].toString(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  StudentEachDetail(
                    title: 'contact:',
                    value: widget.student['contactNumber'].toString(),
                  ),
                ],
              ),
            ),
            const Divider(),
            Card(
              elevation: 4,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    width: double.infinity,
                    child: const Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 34,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Personal Details',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StudentEachDetail(
                          title: 'age:',
                          value: widget.student['age'].toString(),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        StudentEachDetail(
                          title: 'Parent Name:',
                          value: widget.student['parentName'].toString(),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        StudentEachDetail(
                          title: 'Address:',
                          value: widget.student['address'].toString(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
