import 'package:assignment_six/components/dashboard/profile/profile.dart';
import 'package:assignment_six/components/dashboard/student_details/student_details.dart';
import 'package:assignment_six/sql_database_dir/database/db_helper.dart';
import 'package:assignment_six/sql_database_dir/model/student_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AllStudentData extends StatefulWidget {
  const AllStudentData({super.key});

  @override
  State<AllStudentData> createState() => _AllStudentDataState();
}

class _AllStudentDataState extends State<AllStudentData> {
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
    var totalCard = screenWidth > 600 ? 4 : 3;
    var mainIconSize = screenWidth > 600 ? 30.0 : 80.0;
    var secondaryIconSize = screenWidth > 600 ? 30.0 : 35.0;
    var pageMenuTextSize = screenWidth > 600 ? 30.0 : 28.0;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        backgroundColor: Colors.blueAccent.shade400,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(35),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.account_circle_outlined,
                  color: Colors.white,
                  size: mainIconSize,
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Students",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Class : ",
                                style: TextStyle(
                                  color: Colors.white,
                                  // Color for the first part
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15,
                                ),
                              ),
                              TextSpan(
                                text: "10 A - English",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15,
                                ),
                              ),
                              TextSpan(
                                text: " | ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15,
                                ),
                              ),
                              TextSpan(
                                text: "Roll No : 31",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Get.to(Profile());
              },
              child: Icon(
                Icons.edit_note_outlined,
                color: Colors.white,
                size: secondaryIconSize,
              ),
            ),
          ],
        ),
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
                        icon: Icons.person,
                        color: Colors.blueAccent,
                        name: student.name ?? 'No Name',
                        id: student.number ?? 'No ID',
                        onTap: () {
                          Get.to(StudentDetails(), arguments: student.id);
                        },
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
  required IconData icon,
  required Color color,
  required String name,
  required String id,
  required Function() onTap,
  required BuildContext context,
}) {
  var screenWidth = MediaQuery.sizeOf(context).width;
  var cardTextSize = screenWidth > 600 ? 30.0 : 17.0;
  var idTextSize = screenWidth > 600 ? 30.0 : 14.0;
  return GestureDetector(
    onTap: onTap,
    child: Expanded(
      child: GestureDetector(
        onTap: () {
          Get.to(StudentDetails(), arguments: id);
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.withOpacity(0.1),
                    border: Border.all(color: color, width: 2),
                  ),
                  child: Center(
                    child: Icon(
                      icon,
                      size: 40, // Icon size
                      color: color,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
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
    ),
  );
}
