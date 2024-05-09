import 'package:flutter/material.dart';
import 'package:shopsense_app/details.dart';
import 'package:shopsense_app/splash.dart';
import 'package:shopsense_app/shop.dart';
// Import the splash_screen.dart file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple, // Define the primary color
        hintColor: Colors.grey, // Define the accent color

        // You can define other properties of the theme here
      ),
      home: Details(title: ''),
      // Use SplashScreen as the home
    );
  }
}
