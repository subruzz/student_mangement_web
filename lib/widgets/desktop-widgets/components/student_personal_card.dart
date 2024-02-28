import 'package:flutter/material.dart';
import 'package:studentmanagement/widgets/helping-widgets/student_details_item.dart';

class StudentPersonalCard extends StatelessWidget {
  const StudentPersonalCard(
      {super.key,
      required this.address,
      required this.age,
      required this.parent});
  final String parent;
  final String age;
  final String address;
  @override
  Widget build(BuildContext context) {
    return Card(
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
                StudentEachDetail(title: 'age: ', value: age),
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(
                  height: 15,
                ),
                StudentEachDetail(title: 'parentName: ', value: parent),
                const SizedBox(
                  height: 15,
                ),
               StudentEachDetail(title: 'Address: ', value: address)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
