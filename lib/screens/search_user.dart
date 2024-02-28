import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studentmanagement/screens/student_details.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({super.key, required this.student});
  final List<DocumentSnapshot> student;
  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  List<DocumentSnapshot> foundStudents = [];
  @override
  void initState() {
    super.initState();
    foundStudents = widget.student;
  }

  void _runFiler(String enteredValue) {
    List<DocumentSnapshot> results = [];
    if (enteredValue.isEmpty) {
      results = widget.student;
    } else {
      results = widget.student
          .where((element) => element['name']
              .toLowerCase()
              .contains(enteredValue.toLowerCase()))
          .toList();
    }
    setState(() {
      foundStudents = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelStyle: Theme.of(context).textTheme.bodySmall,
                    prefixIcon: const Icon(Icons.search_rounded),
                    label: const Text('Search Students')),
                onChanged: (value) => _runFiler(value),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            foundStudents.isEmpty
                ? const Center(
                    child: Text('No Student Found'),
                  )
                : Expanded(
                    child: ListView.builder(
                    itemCount: foundStudents.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          elevation: 5,
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => StudentDetailsPage(
                                          student: foundStudents[index])));
                            },
                            contentPadding: const EdgeInsets.all(0),
                            leading: foundStudents[index]['profilePicture']
                                    .isEmpty
                                ? const CircleAvatar(
                                    radius: 60,
                                    backgroundImage:
                                        AssetImage('assets/images/profile.png'),
                                  )
                                : CircleAvatar(
                                    radius: 60,
                                    backgroundImage: NetworkImage(
                                        foundStudents[index]['profilePicture']),
                                  ),
                            title: Text(foundStudents[index]['name']),
                            subtitle: Text(foundStudents[index]['batch']),
                          ),
                        ),
                      );
                    },
                  ))
          ],
        ),
      ),
    );
  }
}
