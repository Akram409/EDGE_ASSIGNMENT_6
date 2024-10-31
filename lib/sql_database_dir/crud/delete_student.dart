import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:assignment_six/sql_database_dir/database/db_helper.dart';
import 'package:assignment_six/sql_database_dir/model/student_model.dart';
import 'package:awesome_dialog/awesome_dialog.dart'; // Import AwesomeDialog

class DeleteStudent extends StatefulWidget {
  const DeleteStudent({super.key});

  @override
  State<DeleteStudent> createState() => _DeleteStudentState();
}

class _DeleteStudentState extends State<DeleteStudent> {
  late DatabaseHelper dbHelper;
  List<StudentModel> students = [];

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper.instance;
    loadAllStudents();
  }

  Future<void> loadAllStudents() async {
    final data = await dbHelper.getAllStudentData();
    setState(() {
      students = data.map((e) => StudentModel.fromMap(e)).toList();
    });
  }

  // Function to delete student with confirmation dialog
  void confirmDeleteStudent(String id) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Delete',
      desc: 'Want to delete this student?',
      buttonsTextStyle: const TextStyle(color: Colors.white),
      showCloseIcon: true,
      btnCancelOnPress: () {},
      btnOkText: 'YES',
      btnCancelText: 'NO',
      btnOkOnPress: () {
        deleteStudent(id);
      },
    ).show();
  }

  Future<void> deleteStudent(String id) async {
    await dbHelper.deleteData(id);
    loadAllStudents(); // Refresh the list after deletion
    Get.snackbar(
      'Deleted',
      'Student with ID: $id has been deleted',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
    );
  }

  Widget _buildLeadingImage() {
    return Container(
      margin: const EdgeInsets.only(right: 10), // Adjust margin as needed
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.blueAccent,
          width: 3,
        ),
      ),
      child: ClipOval(
        child: Image.asset(
          "assets/images/profile.png", // Path to your profile image
          height: 50, // Adjust size as needed
          width: 50,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delete Student"),
        backgroundColor: Colors.redAccent,
      ),
      body: students.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return ListTile(
            leading: _buildLeadingImage(),
            title: Text(student.name ?? 'No Name'),
            subtitle: Text('${student.id ?? 'No ID'}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => confirmDeleteStudent(student.id!),
            ),
          );
        },
      ),
    );
  }
}
