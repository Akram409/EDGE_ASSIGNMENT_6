import 'package:assignment_six/home_page.dart';
import 'package:assignment_six/sql_database_dir/database/db_helper.dart';
import 'package:assignment_six/sql_database_dir/model/student_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddStudent> {
  late DatabaseHelper dbHelper;

  var idController = TextEditingController();
  var nameController = TextEditingController();
  var numberController = TextEditingController();
  var emailController = TextEditingController();
  var locationController = TextEditingController();

  final GlobalKey<FormState> noteFormKey = GlobalKey();

  //add notes to database
  Future addStudent() async {
    final newStudentModel = StudentModel(
      id: idController.text,
      name: nameController.text,
      number: numberController.text,
      email: emailController.text,
      location: locationController.text,
    );

    //if data insert successfully, its return row number which is greater that 1 always
    int check = await dbHelper.insertData(newStudentModel.toMap());
    print("Check=$check");
    if (check > 0) {
      Get.snackbar("Success", "Student Data Added",
          snackPosition: SnackPosition.BOTTOM);
      Get.offAll(HomePage());
    } else {
      Get.snackbar("Error", "Error in adding Student Data",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        title: Text(
          "Add Notes",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: noteFormKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              TextFormField(
                controller: idController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Student ID",
                  hintText: "Student ID",
                  prefixIcon: const Icon(Icons.note_alt_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Student ID";
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: nameController,
                maxLines: 3,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Name",
                  hintText: "Name",
                  prefixIcon: const Icon(Icons.notes),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Name";
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: numberController,
                maxLines: 3,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Number",
                  hintText: "Number",
                  prefixIcon: const Icon(Icons.notes),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Phone Number";
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: emailController,
                maxLines: 3,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "email",
                  prefixIcon: const Icon(Icons.notes),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Email Address";
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: locationController,
                maxLines: 3,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Location",
                  hintText: "Location",
                  prefixIcon: const Icon(Icons.notes),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Location";
                  }

                  return null;
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () async {
                  if (noteFormKey.currentState!.validate()) {
                    noteFormKey.currentState!.save();

                    addStudent();
                  }
                },
                child: Text(
                  "Save Notes",
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
