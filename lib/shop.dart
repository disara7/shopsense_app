import 'package:flutter/material.dart';

class Shop extends StatelessWidget {
  const Shop({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    // Calculate the height of each button to fill the screen
    final double buttonHeight = MediaQuery.of(context).size.height / 2;

    return Scaffold(
      body: GridView.count(
        shrinkWrap: true, // Ensure the GridView shrinks to fit its content
        crossAxisCount: 2, // Number of buttons in a row
        childAspectRatio: MediaQuery.of(context).size.width /
            (buttonHeight * 2), // Maintain aspect ratio
        children: <Widget>[
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(20.0),
              backgroundColor: Colors.pink,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(0), // Adjust the radius as needed
              ),
              minimumSize: Size(double.infinity,
                  buttonHeight), // Set minimum size to fill height
            ),
            child: const Text('Button 1'),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(20.0),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(0), // Adjust the radius as needed
              ),
              minimumSize:
                  Size(double.infinity, buttonHeight), // Set button color
            ),
            child: const Text('Button 2'),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(20.0),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(0), // Adjust the radius as needed
              ),
              minimumSize: Size(double.infinity,
                  buttonHeight), // Set minimum size to fill height
              // Set button color
            ),
            child: const Text('Button 3'),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(20.0),
              backgroundColor: Colors.pink,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(0), // Adjust the radius as needed
              ),
              minimumSize: Size(double.infinity,
                  buttonHeight), // Set minimum size to fill height
            ),
            child: const Text('Button 4'),
          ),
        ],
      ),
    );
  }
}
