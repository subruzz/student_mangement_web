import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studentmanagement/screens/add_student.dart';
import 'package:studentmanagement/utils/responsive/responsive_widget.dart';
import 'package:studentmanagement/screens/login_screen.dart';
import 'package:studentmanagement/screens/search_user.dart';
import 'package:studentmanagement/widgets/desktop-widgets/desktop_screens/desktop_student_display.dart';
import 'package:studentmanagement/widgets/helping-widgets/dialog.dart';
import 'package:studentmanagement/widgets/mobile-widgets/mobile_display_student.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<DocumentSnapshot> foundStudents = [];

  void logout() {
    showDialog(
        context: context,
        builder: (ctx) => CustomDialog(
              title: 'Are you sure you want to logout?',
              onClick: () {
                _signOut();
              },
            ));
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
              showGeneralDialog(
                context: context,
                barrierColor: Colors.black54,
                barrierDismissible: true,
                barrierLabel: 'Label',
                pageBuilder: (_, __, ___) {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width >= 600
                          ? MediaQuery.of(context).size.width / 3
                          : MediaQuery.of(context).size.width,
                      child: SearchUser(student: foundStudents),
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.search),
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
            // .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            foundStudents = snapshot.data!.docs;
            return snapshot.data!.docs.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/nodata.avif',
                          width: 400,
                        ),
                        const Text('No Student Record found '),
                      ],
                    ),
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
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/nodata.avif',
                  width: 400,
                ),
                const Text('No Student Record found '),
              ],
            ),
          );
        },
      ),
    );
  }
}
