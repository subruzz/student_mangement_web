
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailedStudetnt extends StatefulWidget {
  const DetailedStudetnt({
    super.key,
    required this.student,
  });
  final DocumentSnapshot student;

  @override
  State<DetailedStudetnt> createState() => _DetailedStudetntState();
}

class _DetailedStudetntState extends State<DetailedStudetnt> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  // void removeStudent(int id, BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (ctx) => AlertDialog(
  //       title: const Text('Are you sure you want to delete?'),
  //       actions: [
  //         TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: const Text('Cancel')),
  //         TextButton(
  //             onPressed: () async {
  //               await SqlHelper.deleteStudent(id);
  //               if (context.mounted) {
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   const SnackBar(
  //                     content: Text("Record deleted"),
  //                   ),
  //                 );

  //                 // Navigator.push(context,
  //                 //     MaterialPageRoute(builder: (ctx) => const HomePage()));
  //               }
  //             },
  //             child: const Text('ok')),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                // removeStudent(widget.student.id!, context);
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
                                    width: 140.0,
                                    height: 140.0,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : ClipOval(
                                  child: Image.network(
                                    widget.student['profilePicture'],
                                    width: 140.0,
                                    height: 140.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                          const SizedBox(
                            width: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.student['name'],
                              ),
                              Text(
                                widget.student['batch'],
                              ),
                            ],
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
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, bottom: 10),
                    child: Row(
                      children: [
                        const Icon(Icons.email),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(widget.student['emailAddress']),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: [
                        const Icon(Icons.email),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(widget.student['contactNumber'].toString()),
                      ],
                    ),
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
                              fontSize: 22,
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
                        Row(
                          children: [
                            Text(
                              'Age:',
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.student['age'].toString(),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                     
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Address:',
                        ),
                        Text(
                          widget.student['address'].toString(),
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
