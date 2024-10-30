import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentDetails extends StatefulWidget {
  const StudentDetails({super.key});

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  @override
  Widget build(BuildContext context) {
    // Get screen width and adjust card size
    var screenWidth = MediaQuery.of(context).size.width;
    var cardWidth = screenWidth > 600 ? screenWidth * 0.6 : screenWidth * 0.9;
    var cardHeight = screenWidth > 600 ? screenWidth * 0.5 : screenWidth * 0.7;

    // Mock student data
    var studentID = "C221161";
    var studentName = "John Doe";
    var location = "New York, USA";
    var section = "10A - English";
    var email = "temp@gmail.com";
    var phone = "+88017XXXXXXX21";
    var rollNo = "31";
    var imageUrl = '';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Details"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: SizedBox(
            width: cardWidth,
            height: cardHeight,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 65,
                  left: 0,
                  right: 0,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: Colors.blueAccent,
                        width: 3.0
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(50, 80, 50, 10),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          _detailRow("Name", studentName),
                          const SizedBox(height: 10),
                          _detailRow("Student ID", studentID),
                          const SizedBox(height: 10),
                          _detailRow("Section", section),
                          const SizedBox(height: 10),
                          _detailRow("Email", email),
                          const SizedBox(height: 10),
                          _detailRow("Location", location),
                          const SizedBox(height: 10),
                          _detailRow("Phone", phone),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.blueAccent,
                          width: 3,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          "assets/images/profile.png",
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
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
                  fontSize: 23,
                ),
              ),
              TextSpan(
                text: value,
                style: GoogleFonts.ebGaramond(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w700,
                  fontSize: 23,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
