import 'package:assignment_six/components/dashboard/all_student_data/all_student_data.dart';
import 'package:assignment_six/components/dashboard/new_student/new_student.dart';
import 'package:assignment_six/components/dashboard/student_details/student_details.dart';
import 'package:assignment_six/components/share/splash/splash.dart';
import 'package:assignment_six/home_page.dart';
import 'package:assignment_six/sql_database_dir/crud/update_student.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BMI Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: Splash(),
    );
  }
}
