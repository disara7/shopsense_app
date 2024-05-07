import 'dart:async';
import 'package:flutter/material.dart';
import 'register.dart'; // Import the register.dart file

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay navigation to register.dart for 5 seconds
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const RegisterScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Your logo or image goes here
            Image.asset(
              'images/logo.png', // Replace 'logo.png' with your logo file
              width: 250,
              height: 250,
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(), // Loading indicator
          ],
        ),
      ),
    );
  }
}
