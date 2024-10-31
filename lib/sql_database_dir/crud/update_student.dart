import 'dart:io';
import 'package:assignment_six/sql_database_dir/crud/update_student_details.dart';
import 'package:assignment_six/sql_database_dir/database/db_helper.dart';
import 'package:assignment_six/sql_database_dir/model/student_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateStudents extends StatefulWidget {
  const UpdateStudents({super.key});

  @override
  State<UpdateStudents> createState() => _UpdateStudentsState();
}

class _UpdateStudentsState extends State<UpdateStudents> {
  //declared variables
  late DatabaseHelper dbHelper;
  List<StudentModel> students = [];

  final products = List<String>.generate(100, (int index) => "Contact $index");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DatabaseHelper.instance;

    //load notes on startup
    loadAllStudents();
  }

//for loading data from db
  Future<List<StudentModel>> loadAllStudents() async {
    final data = await dbHelper.getAllStudentData();
    return data.map((e) => StudentModel.fromMap(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    var totalCard = screenWidth > 600 ? 3 : 2;
    var mainIconSize = screenWidth > 600 ? 30.0 : 80.0;
    var secondaryIconSize = screenWidth > 600 ? 30.0 : 35.0;
    var pageMenuTextSize = screenWidth > 600 ? 30.0 : 25.0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade400,
        title: Text("Student Info Management"),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("All Students",
                style: TextStyle(
                    fontSize: pageMenuTextSize, fontWeight: FontWeight.bold)),
            Divider(),
            Expanded(
              child: FutureBuilder<List<StudentModel>>(
                future: loadAllStudents(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No students found.'));
                  }

                  // If we have data, display it
                  final studentList = snapshot.data!;
                  return GridView.count(
                    crossAxisCount: totalCard,
                    crossAxisSpacing: 13,
                    children: List.generate(studentList.length, (index) {
                      final student = studentList[index];
                      return studentCard(
                        imagePath: student.imagePath ?? '',
                        color: Colors.blueAccent,
                        name: student.name ?? 'No Name',
                        id: student.id ?? 'No ID',
                        context: context,
                      );
                    }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget studentCard({
  required String imagePath,
  required Color color,
  required String name,
  required String id,
  required BuildContext context,
}) {
  var screenWidth = MediaQuery.sizeOf(context).width;
  var screenHeight = MediaQuery.sizeOf(context).height;
  var cardTextSize = screenWidth > 600 ? 30.0 : 17.0;
  var idTextSize = screenWidth > 600 ? 30.0 : 14.0;
  var circleWidth = screenWidth > 600 ? 70.0 : 100.0;
  var circleHeight = screenHeight > 600 ? 70.0 : 100.0;
  var imageCircle = screenHeight > 600 ? 60.0 : 120.0;

  return Expanded(
    child: GestureDetector(
      onTap: () {
        Get.to(UpdateStudentDetails(), arguments: id);
      },
      child: Container(
        // margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: circleWidth,
                height: circleHeight,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(0.1),
                  border: Border.all(color: color, width: 2),
                ),
                child: Center(
                  child: ClipOval(
                    child: imagePath.isNotEmpty && File(imagePath).existsSync()
                        ? Image.file(
                      File(imagePath),
                      height: imageCircle,
                      width: imageCircle,
                      fit: BoxFit.cover,
                    )
                        : Image.asset(
                      "assets/images/profile.png",
                      height: imageCircle,
                      width: imageCircle,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                name,
                textAlign: TextAlign.center, // Center-align the text
                style: GoogleFonts.ebGaramond(
                  fontSize: cardTextSize,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                id,
                textAlign: TextAlign.center, // Center-align the text
                style: GoogleFonts.ebGaramond(
                  fontSize: idTextSize,
                  fontWeight: FontWeight.w300,
                ),
              ),

            ],
          ),
        ),
      ),
    ),
  );
}
