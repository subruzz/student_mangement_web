import 'package:flutter/material.dart';

class StudentContact extends StatelessWidget {
  const StudentContact(
      {super.key,
      required this.batch,
      required this.contact,
      required this.email,
      required this.name});
  final String name;
  final String batch;
  final String email;
  final String contact;
  @override
  Widget build(BuildContext context) {
    return Card(
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name,
                      ),
                      Text(
                        batch,
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
                Text(email),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Row(
              children: [
                const Icon(Icons.phone),
                const SizedBox(
                  width: 10,
                ),
                Text(contact),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
