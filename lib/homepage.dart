import 'package:flutter/material.dart';
import 'package:student_manager/add_student.dart';
import 'package:student_manager/view_all_infos.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Student Information",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddStudent()));
              },
              child: Container(
                height: 50,
                width: 300,
                child: Center(
                  child: Text(
                    "Add Student",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
              ),
            ),

            SizedBox(
              height: 7,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllInfos()));
              },
              child: Container(
                height: 50,
                width: 300,
                child: Center(
                  child: Text(
                    "View All Student",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
