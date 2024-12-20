import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_manager/homepage.dart';
import 'Database/db_helper.dart';
import 'Model/info.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  late DatabaseHelper dbHelper;
  var nameeditingcontroller = TextEditingController();
  var studentideditingcontroller = TextEditingController();
  var phoneeditingcontroller = TextEditingController();
  var emaileditingcontroller = TextEditingController();
  var loactioneditingcontroller = TextEditingController();

  final GlobalKey<FormState> infoFormKey = GlobalKey();

  // Adding information to the database
  Future<void> AddStudents() async {
    final newinfo = Info(
      name: nameeditingcontroller.text,
      student_id: studentideditingcontroller.text,
      phone: phoneeditingcontroller.text,
      email: emaileditingcontroller.text,
      location: loactioneditingcontroller.text,
    );

    int check = await dbHelper.insertData(newinfo); // Insert the Info object directly
    print("Check=$check");

    if (check > 0) {
      Get.snackbar("Success", "Student Info Added", snackPosition: SnackPosition.BOTTOM);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Homepage()),
              (route) => false); // Navigate to Homepage and remove previous screens
    } else {
      Get.snackbar("Error", "Failed to add student", snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper.instance;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double formWidth = screenWidth * 0.8;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add New Student",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: infoFormKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: SizedBox(
                    width: formWidth,
                    child: TextFormField(
                      controller: nameeditingcontroller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Enter Your Name",
                        hintText: "Name",
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter Your name";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: SizedBox(
                    width: formWidth,
                    child: TextFormField(
                      controller: studentideditingcontroller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Enter Your Student ID",
                        hintText: "ID",
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your ID";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: SizedBox(
                    width: formWidth,
                    child: TextFormField(
                      controller: phoneeditingcontroller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Enter Your Contact Number",
                        hintText: "Phone",
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter Your number";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: SizedBox(
                    width: formWidth,
                    child: TextFormField(
                      controller: emaileditingcontroller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Enter Your Email",
                        hintText: "Email Address",
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter Email";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: SizedBox(
                    width: formWidth,
                    child: TextFormField(
                      controller: loactioneditingcontroller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Enter Your Location",
                        hintText: "Present Address",
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter Your location";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: SizedBox(
                    width: 250,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          elevation: 30,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(15.0)),
                          )),
                      onPressed: () {
                        if (infoFormKey.currentState!.validate()) {
                          infoFormKey.currentState!.save();
                          AddStudents();
                        }
                      },
                      child: Text(
                        "Save Student",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
