import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studentmanagement/responsive/add_student.dart';
import 'package:studentmanagement/responsive/responsive_widget.dart';
import 'package:studentmanagement/screens/login_screen.dart';
import 'package:studentmanagement/widgets/desktop-widgets/desktop_student_display.dart';
import 'package:studentmanagement/widgets/mobile-widgets/mobile_display_student.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.email});
  final String email;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void logout() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.red,
                ),
              ),
              IconButton(
                  onPressed: () {
                    _signOut().then((value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                          (route) => false,
                        ));
                  },
                  icon: const Icon(
                    Icons.check,
                    color: Colors.green,
                  )),
            ],
          )
        ],
        title: const Text(
          'Are you sure you want to logout?',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.normal, fontSize: 18),
        ),
      ),
    );
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  final CollectionReference students =
      FirebaseFirestore.instance.collection('studentCollection');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => const AddDetails(
                      student: null,
                      studentId: null,
                    )),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 41, 116, 176),
        title: const Text(
          'Student Records',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // setState(() {
              //   isScreen = !isScreen;
              // });
            },
            icon: const Icon(Icons.grid_view),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () {
              logout();
            },
            icon: const Icon(Icons.logout),
            color: Colors.black,
          )
        ],
      ),
      body: StreamBuilder(
        stream: students
            .where('tid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            // .orderBy('timeStamp', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return snapshot.data!.docs.isEmpty
                ? const Center(
                    child: Text('No Student Record found '),
                  )
                : ResponiveLayout(
                    desktop:
                        DesktopDisplayStudents(student: snapshot.data!.docs),
                    tablet:
                        DesktopDisplayStudents(student: snapshot.data!.docs),
                    mobile: MobileDisplayStudents(
                      student: snapshot.data!.docs,
                    ));
          }
          return const Center(
            child: Text('No Student Record found '),
          );
        },
      ),
    );
  }
}
