import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Details extends StatefulWidget {
  const Details({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool brailleKeypadEnabled = false;
  List<String> cardno = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 6), () {
      // speakSentence(
      //     'To purchase this item, please confirm by tapping on the top right corner of the screen.');
    });

    // Initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40), // Adjust the duration as needed
    )..repeat();

    // Initialize rotation animation
    _animation = Tween(begin: 0.0, end: 2 * 3.1415).animate(_controller);
  }

  Future<void> speakSentence(String sentence) async {
    FlutterTts flutterTts = FlutterTts();
    await flutterTts.setLanguage('en-UK');
    await flutterTts.setSpeechRate(1.0);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(2.0);
    await flutterTts.setVoice({"name": "Karen", "locale": "en-AU"});
    await flutterTts.speak(sentence);
  }

  void toggleBrailleKeypad() {
    setState(() {
      brailleKeypadEnabled = !brailleKeypadEnabled;
    });
  }

  void onTapBrailleKey(String key) {
    setState(() {
      cardno.add(key);
      if (cardno.length >= 12) {
        // Close the keypad when 12 keys are tapped
        brailleKeypadEnabled = false;
      }
    });
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
                child: const Text('deets'),
              ),
              ElevatedButton(
                onPressed: () {
                  speakSentence(
                      'The braille keypad is now enabled for you to type in your Visa or Mastercard number to continue the checkout process.');
                  toggleBrailleKeypad();
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
          if (brailleKeypadEnabled)
            Center(
              child: Container(
                color: Colors.black54,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 1; i <= 6; i++)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int j = 1; j <= 2; j++)
                            BrailleKey(
                              onTap: onTapBrailleKey,
                              value: (i - 1) * 2 + j,
                            ),
                        ],
                      ),
                  ],
                ),
              ),
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

class BrailleKey extends StatelessWidget {
  final int value;
  final void Function(String) onTap;

  const BrailleKey({Key? key, required this.value, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(value.toString()),
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Text(
          value.toString(),
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
