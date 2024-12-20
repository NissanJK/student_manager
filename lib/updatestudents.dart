import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'Database/db_helper.dart';
import 'Model/info.dart';
import 'package:student_manager/homepage.dart';

class UpdateStudents extends StatefulWidget {
  final Info info; // Pass the Info object
  const UpdateStudents({super.key, required this.info});

  @override
  State<UpdateStudents> createState() => _UpdateStudentsState();
}

class _UpdateStudentsState extends State<UpdateStudents> {
  late DatabaseHelper dbHelper;

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  final GlobalKey<FormState> studentFormKey = GlobalKey();

  int? id;

  // Update student data in the database
  Future updateStudent(int id) async {
    final updatedStudent = Info(
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
    );

    int check = await dbHelper.updateData(updatedStudent.toMap() as Info,id);
    print("Check=$check");
    if (check > 0) {
      Fluttertoast.showToast(msg: "Student data has been updated successfully");
      Get.offAll(Homepage());
    } else {
      Fluttertoast.showToast(msg: "Failed to update student data");
    }
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper.instance;
    // Populate controllers with existing data from the student passed in
    nameController.text = widget.info.name!;
    emailController.text = widget.info.email!;
    phoneController.text = widget.info.phone!;
    id = widget.info.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        title: Text(
          "Update Student Info",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: studentFormKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              // Name Text Field
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Name",
                  hintText: "Enter student's name",
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter student's name";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Email Text Field
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Enter student's email",
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter student's email";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Phone Text Field
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Phone",
                  hintText: "Enter student's phone number",
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter student's phone number";
                  }
                  return null;
                },
              ),
              SizedBox(height: 50),

              // Update Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () async {
                  if (studentFormKey.currentState!.validate()) {
                    studentFormKey.currentState!.save();
                    updateStudent(id!);
                  }
                },
                child: const Text(
                  "Update Student",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
