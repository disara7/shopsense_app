import 'package:flutter/material.dart';
import 'package:shopsense_app/register.dart';
import 'package:shopsense_app/shop.dart';
import 'package:shopsense_app/splash.dart';
// Import the splash_screen.dart file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple, // Define the primary color
        hintColor: Colors.grey, // Define the accent color

        // You can define other properties of the theme here
      ),
      home: SplashScreen(),
      // Use SplashScreen as the home
    );
  }
}
