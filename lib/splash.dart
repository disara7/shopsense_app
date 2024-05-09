import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shopsense_app/guide.dart';
import 'package:shopsense_app/register.dart'; // Import the register.dart file

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // Adjust duration as needed
    );

    // Define animation
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);

    // Start the animation
    _animationController.forward();

    // Delay navigation to register.dart for 5 seconds
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Guide()),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Animated logo or image goes here
              AnimatedContainer(
                duration:
                    const Duration(seconds: 2), // Adjust duration as needed
                curve: Curves.easeInOut,
                child: Image.asset(
                  'assets/images/logo.png', // Replace 'logo.png' with your logo file
                  width: 250,
                  height: 250,
                ),
              ),
              const SizedBox(height: 30),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
              ), // Loading indicator
            ],
          ),
        ),
      ),
    );
  }
}
