import 'package:assignment_six/components/dashboard/all_student_data/all_student_data.dart';
import 'package:assignment_six/components/dashboard/new_student/new_student.dart';
import 'package:assignment_six/sql_database_dir/crud/delete_student.dart';
import 'package:assignment_six/sql_database_dir/crud/update_student.dart';
import 'package:assignment_six/sql_database_dir/model/student_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:assignment_six/sql_database_dir/database/db_helper.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //declared variables
  late DatabaseHelper dbHelper;
  List<StudentModel> students = [];

  @override
  void initState() {
    super.initState();
    //initializing dbHelper
    dbHelper = DatabaseHelper.instance;

    //load students on startup
    loadAllNotes();
  }

  //for loading data from db
  Future loadAllNotes() async {
    final data = await dbHelper.getAllStudentData();
    setState(() {
      //This line converts a list of map entries (database records) into a list of Note objects using the Note.fromMap method, making it easier to work with custom objects in your app.
      //each element is a map, represented by e
      students = data.map((e) => StudentModel.fromMap(e)).toList();
    });
  }

  //for deleting a note
  Future deleteNote(String id) async {
    int check = await dbHelper.deleteData(id);
    if (check > 0) {
      Fluttertoast.showToast(msg: "Student Data deleted successfully");
      loadAllNotes();
    } else {
      Fluttertoast.showToast(msg: "Failed to delete Student Data");
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    var screenHeight = MediaQuery.sizeOf(context).height;
    var mainIconSize = screenWidth > 600 ? 80.0 : 70.0;
    var secondaryIconSize = screenWidth > 600 ? 30.0 : 35.0;
    var pageMenuTextSize = screenWidth > 600 ? 20.0 : 28.0;
    var toolbarHeight = screenHeight > 800 ? 150.0 : 130.0;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: toolbarHeight,
        backgroundColor: Colors.blueAccent.shade400,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(37),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 2, color: Colors.white),
                    // borderRadius: BorderRadius.circular(10)
                  ),
                  child: Image.asset(
                    "assets/images/profile.png",
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome!",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
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
                                text: "Akram Hossain",
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
            // GestureDetector(
            //   onTap: (){
            //     Get.to(Profile());
            //   },
            //   child: Icon(
            //     Icons.edit_note_outlined,
            //     color: Colors.white,
            //     size: secondaryIconSize,
            //   ),
            // ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Dashboard",
                style: TextStyle(
                    fontSize: pageMenuTextSize, fontWeight: FontWeight.bold)),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 25,
                    children: [
                  buildGridItem(
                    icon: Icons.person_pin_outlined,
                    color: Colors.greenAccent,
                    text: "All Students",
                    onTap: () {
                      Get.to(AllStudentData());
                    },
                    context: context,
                  ),
                  buildGridItem(
                    icon: Icons.person_add_alt,
                    color: Colors.blue,
                    text: "New Student",
                    onTap: () {
                      Get.to(NewStudent());
                    },
                    context: context,
                  ),
                  buildGridItem(
                    icon: Icons.person_search_outlined,
                    color: Colors.blueGrey,
                    text: "Update Student",
                    onTap: () {
                      Get.to(UpdateStudents());
                    },
                    context: context,
                  ),
                  buildGridItem(
                    icon: Icons.person_remove_outlined,
                    color: Colors.red,
                    text: "Delete Student",
                    onTap: () {
                      Get.to(DeleteStudent());
                    },
                    context: context,
                  ),
                ])),
          ],
        ),
      ),
    );
  }
}

Widget buildGridItem({
  required IconData icon,
  required Color color,
  required String text,
  required Function() onTap,
  required BuildContext context,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: color),
                borderRadius: BorderRadius.circular(20),
                color: color),
            child: Icon(icon, size: 45, color: Colors.white),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          text,
          style: GoogleFonts.ebGaramond(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
