import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Shop extends StatefulWidget {
  const Shop({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 6), () {
      speakSentence(
          'Great! Heres what i found for you that match what you just described! The first dress is an orange floral knee length dress with a frilly skirt. If you want more details about this tap on the top right corner of the screen. or if you want to hear about the next dress, tap on the bottom right corner of the screen.');
    });

    // Initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 40), // Adjust the duration as needed
    )..repeat();

    // Initialize rotation animation
    _animation = Tween(begin: 0.0, end: 2 * 3.1415).animate(_controller);
  }

  Future<void> speakSentence(String sentence) async {
    FlutterTts flutterTts = FlutterTts();
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(1.0);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(2.0);
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
                      'Sure, let me repeat what i just said. Please describe what kind of a clothing item you are looking for, today. After you describe, I will come up with a few clothes that match your description and if the item i describe matches your desire, please tap on the top right corner of the screen to get more details about the item. Or, if you want to hear about the other options you have tap on the bottom right corner of the screen. if you want to go back to the previous item, tap on the bottom left corner of the screen, AND if you want me to repeat what i just said, you can tap on the top left corner of the screen.');
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
                child: const Text(''),
              ),
              ElevatedButton(
                onPressed: () {
                  speakSentence(
                      'Excellent choice! Let me describe this dress for you. Imagine slipping into a dress thats a tactile celebration of summer: soft fabric adorned with playful frills and a lively floral pattern, all in a radiant orange hue. Its like wearing sunshine itself, with every touch revealing its vibrant warmth. This delightful creation hugs your curves gently, with frills and ruffles adding a delightful sensation to each movement. The intricate floral pattern, though unseen, can be felt like delicate petals against your skin. With this dress, youll embody the essence of summer, exuding energy and vitality wherever you go. Whether for a leisurely stroll or a gathering with friends, youll feel both stylish and comfortable, inviting admiration with every step.');
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
              ElevatedButton(
                onPressed: () {
                  speakSentence(
                      'The next dress i found for you is a comfortable casual dress with a smoked bust to make you look smart.');
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
                child: const Text(''),
              ),
            ],
          ),
          Positioned.fill(
            child: Center(
              child: RotationTransition(
                turns: _animation,
                child: Image.asset(
                  'images/shopz.png',
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
