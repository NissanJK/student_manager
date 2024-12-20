import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:student_manager/add_student.dart';
import 'package:student_manager/updatestudents.dart';

import 'Database/db_helper.dart';
import 'Model/info.dart';

class ViewAllInfos extends StatefulWidget {
  const ViewAllInfos({super.key});

  @override
  State<ViewAllInfos> createState() => _ViewAllInfosState();
}

class _ViewAllInfosState extends State<ViewAllInfos> {
  late DatabaseHelper dbHelper;
  List<Info> infos = [];

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper.instance;
    loadAllStudents();
  }

  // Fetch all students from the database
  Future loadAllStudents() async {
    final data = await dbHelper.getAllData(); // Get all data from database
    setState(() {
      // Ensure the data is mapped correctly
      infos = List<Info>.from(data.map((e) => Info.fromMap(e as Map<String, dynamic>)));
    });
  }


  // Delete student data
  Future deleteNote(int id) async {
    int check = await dbHelper.deleteData(id);
    if (check > 0) {
      Fluttertoast.showToast(
          msg: "Student data has been deleted successfully");
      loadAllStudents();
    } else {
      Fluttertoast.showToast(msg: "Failed to delete data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Students",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: infos.isEmpty
          ? const Center(
        child: Text("No student data available!"),
      )
          : ListView.builder(
          itemCount: infos.length,
          itemBuilder: (context, index) {
            Info inf = infos[index];
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListTile(
                contentPadding: const EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.blue, width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                onTap: () {
                  // Navigate to UpdateStudents page with the current student's data
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateStudents(info: inf),
                    ),
                  );
                },
                title: Text(
                  inf.name!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(inf.email!),
                leading: const Icon(
                  Icons.mail_outline,
                  size: 40,
                ),
                trailing: IconButton(
                  onPressed: () {
                    // Show confirmation dialog for deletion
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.question,
                      headerAnimationLoop: false,
                      animType: AnimType.bottomSlide,
                      title: 'Delete',
                      desc: 'Do you want to delete this student data?',
                      buttonsTextStyle: const TextStyle(color: Colors.white),
                      showCloseIcon: true,
                      btnCancelOnPress: () {},
                      btnOkText: 'YES',
                      btnCancelText: 'NO',
                      btnOkOnPress: () {
                        deleteNote(inf.id!); // Call the delete function
                        Get.back();
                      },
                    ).show();
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(
          side: BorderSide(color: Colors.blue),
        ), // Circle shape for the button
        backgroundColor: Colors.blue,
        tooltip: "Add Student",
        mini: false,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddStudent()),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
