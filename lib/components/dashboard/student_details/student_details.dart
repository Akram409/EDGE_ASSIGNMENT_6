import 'dart:io';

import 'package:assignment_six/sql_database_dir/database/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentDetails extends StatefulWidget {
  const StudentDetails({super.key});

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  Map<String, dynamic>? studentData;
  @override
  void initState() {
    super.initState();
    loadStudentData();
  }

  // Load student data from the database
  Future<void> loadStudentData() async {
    String studentID = Get.arguments;
    print("Loading student data for ID: $studentID");
    var data = await DatabaseHelper.instance.getStudentDataById(studentID);
    setState(() {
      studentData = data;
    });
  }



  @override
  Widget build(BuildContext context) {
  print(studentData);
    // Get screen width and adjust card size
    var screenWidth = MediaQuery.of(context).size.width;
    var cardWidth = screenWidth > 600 ? screenWidth * 0.6 : screenWidth * 0.9;
    var cardHeight = screenWidth > 600 ? screenWidth * 0.5 : screenWidth * 0.9;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Details"),
        backgroundColor: Colors.blueAccent,
      ),
      body: studentData == null
          ? const Center(child: CircularProgressIndicator())
          : Center(
        child: SizedBox(
          width: cardWidth,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Align(
                alignment: Alignment.center,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: Colors.blueAccent,
                      width: 3.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _detailRow("Name", studentData?['name'] ?? ''),
                        const SizedBox(height: 10),
                        _detailRow("Student Id", studentData?['id']?.toString() ?? ''),
                        const SizedBox(height: 10),
                        _detailRow("Email", studentData?['email'] ?? ''),
                        const SizedBox(height: 10),
                        _detailRow("Location", studentData?['location'] ?? ''),
                        const SizedBox(height: 10),
                        _detailRow("Phone", studentData?['number']?.toString() ?? ''),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: EdgeInsets.all(3),
                  margin: const EdgeInsets.only(top: 95),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.blueAccent,
                      width: 3,
                    ),
                  ),
                  child: ClipOval(
                    child: studentData?['imagePath'] != null &&
                        File(studentData!['imagePath']).existsSync()
                        ? Image.file(
                      File(studentData!['imagePath']),
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    )
                        : Image.asset(
                      "assets/images/profile.png",
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "$label: ",
                style: GoogleFonts.ebGaramond(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              TextSpan(
                text: value,
                style: GoogleFonts.ebGaramond(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
