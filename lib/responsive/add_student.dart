import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:studentmanagement/models/student_details.dart';
import 'package:studentmanagement/utils/pick_image.dart';
import 'package:studentmanagement/utils/storage_methods.dart';
import 'package:studentmanagement/utils/student_services.dart';

class AddDetails extends StatefulWidget {
  const AddDetails({
    super.key,
  });

  @override
  State<AddDetails> createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  // File? selectedImage;
  DateTime? currentDate;
  final CollectionReference students =
      FirebaseFirestore.instance.collection('studentCollection');
  void _addStudent() async {
    String res = await StudentServices.addStuent(
        studenName: _nameController.text.trim(),
        parentName: _parentController.text.trim(),
        batch: _batchController.text.trim(),
        age: int.parse(_ageController.text),
        uid: FirebaseAuth.instance.currentUser!.uid,
        address: _addressController.text,
        email: _emailController.text.trim(),
        dob: currentDate!,
        number: int.parse(_phoneController.text),
        profilePic: _image);
    showSnackBar(res);
    Navigator.pop(context);
  }

  void showSnackBar(String msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Uint8List? _image;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void saveProfile() {}
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _parentController = TextEditingController();

  final _batchController = TextEditingController();

  final _emailController = TextEditingController();

  final _addressController = TextEditingController();

  final _phoneController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _nameController.clear();
    _ageController.clear();
    _batchController.clear();
    _addressController.clear();
    _phoneController.clear();
    _emailController.clear();
    currentDate = null;
    // selectedImage = null;
    super.dispose();
  }

//   @override
//   void initState() {
//     super.initState();
//     if (widget.id != null) {
//       fetchStudent();
//     }
//   }

// // if id present get values to controller
//   void fetchStudent() async {
//     final list = await SqlHelper.students();
//     final student = list.firstWhere((element) => element.id == widget.id);
//     setState(() {
//       _nameController.text = student.name;
//       _ageController.text = student.age.toString();
//       _batchController.text = student.batch;
//       _phoneController.text = student.contactNumber.toString();
//       _emailController.text = student.emailAddress;
//       _addressController.text = student.address;
//       currentDate = student.dob;
//       imageString = student.profilePicture;
//     });
//   }

// // insert to database
//   Future<void> _addiItem() async {
//     final age = int.tryParse(_ageController.text);
//     final number = int.tryParse(_phoneController.text);

//     var student = StudentDetails(
//       parentName: _parentController.text,
//       name: _nameController.text,
//       age: age!,
//       batch: _batchController.text,
//       address: _addressController.text,
//       contactNumber: number!,
//       emailAddress: _emailController.text,
//       dob: currentDate!,
//       profilePicture: imageString,
//     );

//     try {
//       await SqlHelper.insertStudent(student);
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text("Record Added"),
//           ),
//         );
//       }
//       widget.loadStudents();
//     } catch (e) {
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content:
//               const Text('Error Adding student details. Please try again.'),
//           duration: const Duration(seconds: 3),
//           action: SnackBarAction(
//               label: 'Retry',
//               onPressed: () {
//                 _addiItem();
//               }),
//         ));
//       }
//     }
//   }

  void showDate() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 50, now.month, now.day);
    final lastDate = now;

    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    setState(() {
      currentDate = date;
    });
  }

  // String? imageString;
  // Future<void> _pickImageGallery() async {
  //     XFile?  pickedImage =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);

  //   if (pickedImage != null) {
  //     setState(() {
  //       _image = pickedImage.readAsBytes();
  //     });
  //   }
  // }

//   void _updateDetails(int id) async {
//     final age = int.tryParse(_ageController.text);
//     final number = int.tryParse(_phoneController.text);

//     final student = StudentDetails(
//       parentName: _parentController.text,
//       name: _nameController.text,
//       age: age!,
//       batch: _batchController.text,
//       address: _addressController.text,
//       contactNumber: number!,
//       emailAddress: _emailController.text,
//       profilePicture: imageString,
//       dob: currentDate!,
//     );

//     try {
//       await SqlHelper.updateStudent(student, id);
//       widget.loadStudents();
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text('Student Details Updated'),
//           duration: Duration(seconds: 3),
//         ));
//       }
//     } catch (e) {
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content:
//               const Text('Error updating student details. Please try again.'),
//           duration: const Duration(seconds: 3),
//           action: SnackBarAction(
//               label: 'Retry',
//               onPressed: () {
//                 _updateDetails(id);
//               }),
//         ));
//       }
//     }
//   }

//   void _sumbitDetails() {
//     if (currentDate == null) {
//       showDialog(
//         context: context,
//         builder: (ctx) => AlertDialog(
//           title: const Text('Date of birth not entered'),
//           content: const Text('Make sure you to enter Date of birth'),
//           actions: [
//             TextButton(
//                 onPressed: () {
//                   Navigator.pop(ctx);
//                 },
//                 child: const Text('Okay'))
//           ],
//         ),
//       );
//       return;
//     }
//     _addiItem();
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Add Student Details'),
          backgroundColor: const Color.fromARGB(255, 41, 116, 176)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50.0),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Stack(
                      children: [
                        _image == null
                            ? const CircleAvatar(
                                radius: 64,
                                backgroundImage: AssetImage(
                                    'assets/images/login_image_3bd54d0c.png'),
                              )
                            : CircleAvatar(
                                radius: 64,
                                backgroundImage: MemoryImage(_image!),
                              ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              selectImage();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLength: 15,
                    controller: _nameController,
                    decoration: const InputDecoration(
                      label: Text('Name'),
                      hintText: 'Name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name can\'t be empty';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLength: 15,
                    controller: _parentController,
                    decoration: const InputDecoration(
                      label: Text('Parent Name'),
                      hintText: 'Parent Name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name can\'t be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _ageController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            label: Text('Age'),
                            hintText: 'Age',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                          ),
                          validator: (value) {
                            final age = int.tryParse(value!);
                            if (age == null || age < 1 || age > 120) {
                              return 'Enter a valid age';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _batchController,
                          decoration: const InputDecoration(
                            label: Text('Batch'),
                            hintText: 'Batch',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter the Batch';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(currentDate == null
                          ? 'DOB'
                          : DateFormat.yMd().format(currentDate!)),
                      IconButton(
                          onPressed: () {
                            showDate();
                          },
                          icon: const Icon(Icons.calendar_month))
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      label: Text('Contact'),
                      hintText: 'Contact',
                      prefixIcon: Icon(Icons.phone_android),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a phone number';
                      }

                      final phoneRegExp = RegExp(r'^\d{10}$');
                      if (!phoneRegExp.hasMatch(value)) {
                        return 'Enter a valid 10-digit phone number';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _emailController,
                    decoration: const InputDecoration(
                      label: Text('E-mail'),
                      hintText: 'E-mail',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email address';
                      }

                      // Regular expression for a simple email validation
                      final emailRegExp = RegExp(
                        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
                      );

                      if (!emailRegExp.hasMatch(value)) {
                        return 'Enter a valid email address';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _addressController,
                      decoration: const InputDecoration(
                        labelText: 'Address',
                        hintText: 'Enter the address',
                        prefixIcon: Icon(Icons.location_on),
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid address';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            padding:
                                const EdgeInsets.only(left: 30, right: 30)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _addStudent();
                          }
                          // if (_formKey.currentState!.validate()) {
                          //   if (widget.id == null) {
                          //     _sumbitDetails();
                          //   }
                          //   if (widget.id != null) {
                          //     _updateDetails(widget.id!);
                          //   }

                          //   Navigator.pop(context);
                          // }
                        },
                        child: const Text(
                          'Submit',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
