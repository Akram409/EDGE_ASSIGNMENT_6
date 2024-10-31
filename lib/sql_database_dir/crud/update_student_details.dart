import 'package:assignment_six/home_page.dart';
import 'package:assignment_six/sql_database_dir/model/student_model.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../sql_database_dir/database/db_helper.dart';

class UpdateStudentDetails extends StatefulWidget {
  const UpdateStudentDetails({super.key});

  @override
  State<UpdateStudentDetails> createState() => _UpdateStudentDetailsState();
}

class _UpdateStudentDetailsState extends State<UpdateStudentDetails> {
  Map<String, dynamic>? studentData;
  String studentID = Get.arguments;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper.instance;
    loadStudentData();
  }
  Future<void> loadStudentData() async {
    var data = await DatabaseHelper.instance.getStudentDataById(studentID);
    if (data != null) {
      setState(() {
        studentData = data;
        // Set the text fields with the current student data
        studentNameController.text = data['name'];
        studentIDController.text = data['id'];
        emailController.text = data['email'];
        locationController.text = data['location'];
        phoneController.text = data['number']?.toString() ?? '';
      });
    }
  }

  late DatabaseHelper dbHelper;
  File? photo;
  final ImagePicker picker = ImagePicker();

  // Controllers for TextFields
  final TextEditingController studentNameController = TextEditingController();
  final TextEditingController studentIDController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController sectionController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // For camera
  Future<void> imgFromCamera() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1200,
      maxHeight: 1200,
      imageQuality: 100,
    );

    if (pickedFile != null) {
      File savedFile = await saveImageToLocalDirectory(pickedFile);
      setState(() {
        photo = savedFile; // Set the saved file as the selected photo
      });
    } else {
      print('No image selected');
    }
  }

  // For gallery
  Future<void> imgFromGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1200,
      maxHeight: 1200,
      imageQuality: 100,
    );

    if (pickedFile != null) {
      File savedFile = await saveImageToLocalDirectory(pickedFile);
      setState(() {
        photo = savedFile;
      });
    } else {
      print('No image selected');
    }
  }

  // Save the selected image to the local directory
  Future<File> saveImageToLocalDirectory(XFile pickedFile) async {
    final directory = await getApplicationDocumentsDirectory();
    String newPath = '${directory.path}/${pickedFile.name}';
    final savedImage = await File(pickedFile.path).copy(newPath);
    print('Image saved at: $newPath'); // Log the saved path
    return savedImage; // Return the saved file
  }

  void showPickerDialog(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () {
                      imgFromGallery();
                      Navigator.of(context).pop();
                    }),
              ],
            ),
          );
        });
  }

  // Update student details in the database
  Future<void> updateStudent() async {
    try {
      final updatedStudentModel = StudentModel(
        id: studentIDController.text.toString(),
        name: studentNameController.text.toString(),
        number: phoneController.text.toString(),
        email: emailController.text.toString(),
        location: locationController.text.toString(),
      );

      int result = await dbHelper.updateData(
          updatedStudentModel.toMap(), updatedStudentModel.id!);

      if (result > 0) {
        Get.snackbar("Success", "Student Data Updated",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        Get.offAll(HomePage());
      } else {
        Get.snackbar("Error", "Error in updating Student Data",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }


  @override
  Widget build(BuildContext context) {
    print("Retrieved Student Data: $studentData");
    var textFiledGap = 13.0;
    return Scaffold(
        appBar: AppBar(
          title: Center(child: const Text("Update Student")),
          backgroundColor: Colors.blueAccent,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    showPickerDialog(context);
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.blueAccent,
                          width: 3,
                        ),
                      ),
                      child: photo != null
                          ? ClipOval(
                              child: Image.file(
                                photo!,
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            )
                          : ClipOval(
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
              ),
              SizedBox(
                height: 20,
              ),
              _buildTextField("Student Name", studentNameController),
              SizedBox(height: textFiledGap),
              _buildTextField("Student ID", studentIDController, enabled: false), // Disable this field
              SizedBox(height: textFiledGap),
              _buildTextField("Email", emailController, keyboardType: TextInputType.emailAddress),
              SizedBox(height: textFiledGap),
              _buildTextField("Location", locationController),
              SizedBox(height: textFiledGap),
              _buildTextField("Phone", phoneController, keyboardType: TextInputType.phone),
              const SizedBox(height: 20),
              // Submit Button
              SizedBox(
                height: 50,
                width: MediaQuery.sizeOf(context).width / 2.5,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    textStyle: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                    side: const BorderSide(
                        color: Colors.blue, width: 2), // Border color and width
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15), // Spacing
                  ),
                  onPressed: () async {
                    updateStudent(); // Call the update method instead
                  },
                  child: const Text("Update"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}

// Reusable method to build TextFields
// Reusable method to build TextFields
Widget _buildTextField(String label, TextEditingController controller,
    {TextInputType keyboardType = TextInputType.text, bool enabled = true}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
    child: TextField(
      controller: controller,
      keyboardType: keyboardType,
      enabled: enabled, // Set enabled property based on the parameter
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: label,
        labelStyle: TextStyle(color: Colors.blueGrey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
