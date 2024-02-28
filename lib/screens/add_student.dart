import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studentmanagement/services/pick_image.dart';

import 'package:studentmanagement/services/student_services.dart';
import 'package:studentmanagement/widgets/helping-widgets/add_student_textfield.dart';

class AddDetails extends StatefulWidget {
  const AddDetails({super.key, required this.studentId, required this.student});
  final String? studentId;
  final DocumentSnapshot? student;
  @override
  State<AddDetails> createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  @override
  void initState() {
    if (widget.studentId != null) {
      _fetchDetails();
    }
    super.initState();
  }

  String currentImage = '';
  void _fetchDetails() {
    setState(() {
      _nameController.text = widget.student!['name'];
      _parentController.text = widget.student!['parentName'];
      _ageController.text = widget.student!['age'].toString();
      _batchController.text = widget.student!['batch'];
      _phoneController.text = widget.student!['contactNumber'].toString();
      _emailController.text = widget.student!['emailAddress'];
      _addressController.text = widget.student!['address'];
      currentImage = widget.student!['profilePicture'];
      // currentDate = widget.student!['dob'];
      // _image = image;
    });
  }

  bool _isSubmitting = false;
  // File? selectedImage;
  String? currentDate;
  final CollectionReference students =
      FirebaseFirestore.instance.collection('studentCollection');
  void _addStudent() async {
    setState(() {
      _isSubmitting = true;
    });
    String res = await StudentServices.addStuent(
        studenName: _nameController.text.trim(),
        parentName: _parentController.text.trim(),
        batch: _batchController.text.trim(),
        age: int.parse(_ageController.text),
        uid: FirebaseAuth.instance.currentUser!.uid,
        address: _addressController.text,
        email: _emailController.text.trim(),
        number: int.parse(_phoneController.text),
        profilePic: _image);
    showSnackBar(
      res,
    );
    Navigator.pop(context);
  }

  void showSnackBar(String msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.blue, // Change background color
        duration: const Duration(seconds: 3), // Adjust duration
        behavior: SnackBarBehavior.floating, // Use floating behavior
        shape: RoundedRectangleBorder(
          // Apply rounded corners
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(16), // Add some margin
        padding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 12), // Add padding
      ),
    );
  }

  Uint8List? _image;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
      currentImage = '';
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

  void _updateDetails(String id) async {
    setState(() {
      _isSubmitting = true;
    });
    String res = await StudentServices.updateStudent(
        timestamp: widget.student!['timeStamp'],
        sid: widget.student!.id,
        studenName: _nameController.text.trim(),
        parentName: _parentController.text.trim(),
        batch: _batchController.text.trim(),
        age: int.parse(_ageController.text),
        uid: FirebaseAuth.instance.currentUser!.uid,
        address: _addressController.text,
        email: _emailController.text.trim(),
        number: int.parse(_phoneController.text),
        profilePic: _image,
        currentProfile:
            _image == null ? widget.student!['profilePicture'] : null);
    showSnackBar(res);
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            widget.studentId == null ? 'Add Student' : 'Update Student',
          ),
          backgroundColor: const Color.fromARGB(255, 41, 116, 176)),
      body: _isSubmitting
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text('Please wait..This may take some time')
                ],
              ),
            )
          : SafeArea(
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
                              currentImage.isNotEmpty
                                  ? CircleAvatar(
                                      radius: 64,
                                      backgroundImage: NetworkImage(
                                          widget.student!['profilePicture']))
                                  : _image == null
                                      ? const CircleAvatar(
                                          radius: 64,
                                          backgroundImage: AssetImage(
                                              'assets/images/profile.png'),
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
                        const SizedBox(height: 15.0),
                        AddStudentTextField(
                          icon: Icons.person,
                          controller: _nameController,
                          label: 'name',
                          validation: (value) {
                            if (value!.isEmpty) {
                              return 'Name can\'t be empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15.0),
                        AddStudentTextField(
                          icon: Icons.person,
                          controller: _parentController,
                          label: 'parent Name',
                          validation: (value) {
                            if (value!.isEmpty) {
                              return 'Name can\'t be empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        AddStudentTextField(
                          icon: Icons.date_range_outlined,
                          controller: _ageController,
                          label: 'age',
                          validation: (value) {
                            final age = int.tryParse(value!);
                            if (age == null || age < 1 || age > 120) {
                              return 'Enter a valid age';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        AddStudentTextField(
                          icon: Icons.business,
                          controller: _batchController,
                          label: 'Batch',
                          validation: (value) {
                            if (value!.isEmpty) {
                              return 'Enter the Batch';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        AddStudentTextField(
                          icon: Icons.phone,
                          controller: _phoneController,
                          label: 'Contact',
                          validation: (value) {
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
                        AddStudentTextField(
                          icon: Icons.email,
                          controller: _emailController,
                          label: 'email-address',
                          validation: (value) {
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
                        AddStudentTextField(
                            icon: Icons.location_city,
                            maxLines: 3,
                            controller: _addressController,
                            label: 'address',
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a valid address';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 30)),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (widget.studentId == null) {
                                    _addStudent();
                                  }
                                  if (widget.studentId != null) {
                                    _updateDetails(widget.studentId!);
                                  }
                                }
                                // }
                              },
                              child: Text(
                                widget.studentId == null ? 'Submit' : 'Update',
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
