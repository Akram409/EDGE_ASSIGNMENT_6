import 'package:assignment_six/components/dashboard/all_student_data/all_student_data.dart';
import 'package:assignment_six/components/dashboard/new_student/new_student.dart';
import 'package:assignment_six/sql_database_dir/crud/delete_student.dart';
import 'package:assignment_six/sql_database_dir/crud/update_student.dart';
import 'package:flutter/material.dart';


class BottomNavigations extends StatefulWidget {
  const BottomNavigations({super.key});

  @override
  State<BottomNavigations> createState() =>
      _BottomNavigationsState();
}


class _BottomNavigationsState extends State<BottomNavigations> {

  // Index of the selected item in the bottom navigation bar
  int selectedIndex = 0;
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  // List of widgets to be displayed in the bottom navigation bar
  List<Widget>pages = <Widget>[
    AllStudentData(),
    NewStudent(),
    UpdateStudents(),
    DeleteStudent()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bottom Navigation Practice',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Center(
        child: pages.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.person_pin_outlined),
              label: 'All Students',
              backgroundColor: Colors.greenAccent),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_add_alt),
              label: 'New Student',
              backgroundColor: Colors.blueAccent),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_search_outlined),
              label: 'Update Student',
              backgroundColor: Colors.blueGrey),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_remove_outlined),
              label: 'Delete Student',
              backgroundColor: Colors.redAccent),
        ],

        type: BottomNavigationBarType.shifting,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        iconSize: 40,
        onTap: onItemTapped,
      ),
    );
  }
}