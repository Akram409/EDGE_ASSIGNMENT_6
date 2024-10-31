import 'dart:async';
import 'package:assignment_six/home_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  startTimer() async {
    Timer(const Duration(seconds: 3), () {
      // Code
      Get.offAll(HomePage());
    });
  }

  @override

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/student.png",
                    height: MediaQuery.sizeOf(context).height / 3,
                    width: MediaQuery.sizeOf(context).width / 3,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Student",
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        letterSpacing: 5),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Management",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        color: Colors.blue,
                        letterSpacing: 4),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const CircularProgressIndicator(
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}