import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shopsense_app/details.dart'; // Import the details.dart file

class Shop extends StatefulWidget {
  const Shop({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _showImage = false;
  bool _showDress02 = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 30), () {
      speakSentence(
          'Great! Here\'s what I found for you that matches what you just described! The first dress is an orange floral knee-length dress with a frilly skirt. If you want more details about this, tap on the top right corner of the screen. Or, if you want to hear about the next dress, tap on the bottom right corner of the screen.');
    });

    // Initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40), // Adjust the duration as needed
    )..repeat();

    // Initialize rotation animation
    _animation = Tween(begin: 0.0, end: 2 * 3.1415).animate(_controller);

    // Delay showing the image
    Future.delayed(Duration(seconds: 30), () {
      setState(() {
        _showImage = true;
      });
    });
  }

  Future<void> speakSentence(String sentence) async {
    FlutterTts flutterTts = FlutterTts();
    await flutterTts.setLanguage('locale.UK');
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
    await flutterTts.setVoice({"name": "Karen", "locale": "en-AU"});
    await flutterTts.speak(sentence);
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the height of each button to fill the screen
    final double buttonHeight = MediaQuery.of(context).size.height / 2;

    return Scaffold(
      body: Stack(
        children: [
          GridView.count(
            shrinkWrap: true, // Ensure the GridView shrinks to fit its content
            crossAxisCount: 2, // Number of buttons in a row
            childAspectRatio: MediaQuery.of(context).size.width /
                (buttonHeight * 2), // Maintain aspect ratio
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  speakSentence(
                      'Sure, let me repeat what I just said. Please describe what kind of clothing item you are looking for today. After you describe, I will come up with a few clothes that match your description, and if the item I describe matches your desire, please tap on the top right corner of the screen to get more details about the item. Or, if you want to hear about the other options you have, tap on the bottom right corner of the screen. If you want to go back to the previous item, tap on the bottom left corner of the screen, AND if you want me to repeat what I just said, you can tap on the top left corner of the screen.');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20.0),
                  backgroundColor: Colors.pink[100],
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(0), // Adjust the radius as needed
                  ),
                  minimumSize: Size(double.infinity,
                      buttonHeight), // Set minimum size to fill height
                ),
                child: const Text('shop'),
              ),
              ElevatedButton(
                onPressed: () {
                  speakSentence(
                      'Excellent choice! Let me describe this dress for you. Its got a vibrant checkered pattern that is black and white. The price is 2500 rupees. This can be worn for casual occassions. the brand is insomnia and 5 items are available in stock. It can be washed in the washing machine. If you wish to purchase this dress please tap on the top right corner of the screen.');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Details(
                              title: '',
                            )),
                  );
                },
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
                child: const Text(''),
              ),
              ElevatedButton(
                onPressed: () {
                  speakSentence('Sure, you can re-describe what you wish for.');
                },
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
                child: const Text(''),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const Details(
                  //       title: 'Details Screen',
                  //     ),
                  //   ),
                  // );
                },
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showDress02 = true;
                      _showImage = false;
                    });
                    speakSentence(
                        'The next dress I found for you is a comfortable casual dress with a smoked bust to make you look smart.');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20.0),
                    backgroundColor: Colors.pink[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          0), // Adjust the radius as needed
                    ),
                    minimumSize: Size(double.infinity,
                        buttonHeight), // Set minimum size to fill height
                  ),
                  child: const Text(''),
                ),
              ),
            ],
          ),
          if (_showImage)
            Positioned.fill(
              child: Center(
                child: Transform.scale(
                  scale: 0.7, // Adjust the scale factor as needed
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 205, 205, 205),
                        width: 7.0, // Adjust the border width as needed
                      ),
                    ),
                    child: Image.asset(
                      'assets/images/dress01.jpeg',
                    ),
                  ),
                ),
              ),
            ),
          if (_showDress02)
            Positioned.fill(
              child: Center(
                child: Transform.scale(
                  scale: 0.7, // Adjust the scale factor as needed
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 205, 205, 205),
                        width: 7.0, // Adjust the border width as needed
                      ),
                    ),
                    child: Image.asset(
                      'assets/images/dress02.jpeg',
                    ),
                  ),
                ),
              ),
            ),
          Positioned.fill(
            child: Center(
              child: RotationTransition(
                turns: _animation,
                child: Image.asset(
                  'assets/images/shopz.png',
                  width: MediaQuery.of(context).size.width / 3,
                  // Adjust the width as needed
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
