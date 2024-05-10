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
    await flutterTts.setLanguage('locale.UK');
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
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
      if (cardno.length < 12) {
        cardno.add(key);
        speakSentence(key);
      }
      if (cardno.length >= 12) {
        // Close the keypad when 12 keys are tapped
        speakSentence(
            "You card number is added to your profile successfully. Please tell me the address you wish to get this item delivered. After saying the address, tap on the bottom left corner of the screen to confirm."); // Add the sentence to be spoken once the keypad disappears

        brailleKeypadEnabled = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the height of each button to fill the screen
    final double buttonHeight = MediaQuery.of(context).size.height / 5;

    return Scaffold(
      body: Stack(
        children: [
          GridView.count(
            shrinkWrap: true, // Ensure the GridView shrinks to fit its content
            crossAxisCount: 2, // Number of columns
            childAspectRatio: MediaQuery.of(context).size.width /
                (buttonHeight * 5), // Maintain aspect ratio
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  speakSentence(
                      'Sure, the order for one small sized black and white checkered dress is successfully cancelled and any paid amount is refunded to your account.');
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
                      'Awesome! Lets first add your card details. The braille keypad is now enabled for you to type in your Visa or Mastercard number to continue the checkout process. The keypad has numbers 0 to 9 and are plased in the zig zag pattern. the numbers will be narrated to you as you press. You may start typing now.');
                  toggleBrailleKeypad();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20.0),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(0), // Adjust the radius as needed
                  ),
                  minimumSize: Size(
                      double.infinity, buttonHeight * 5), // Set button size
                ),
                child: const Text(''),
              ),
              ElevatedButton(
                onPressed: () {
                  speakSentence(
                      'Your address which is number 74A, lewelle road, kandy has been added and the order is confirmed. This item will be delivered to you in a week. Please tap on the bottom right corner of the screen to continur shopping ot the top left corner of the screen to cancel the order.');
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
                      'Sure, Lets continue shopping. Tell me what you wish to shop next.');
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
                    for (int i = 0; i < 5; i++)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (int j = 0; j < 2; j++)
                            BrailleKey(
                              onTap: onTapBrailleKey,
                              value: i * 2 + j,
                              size: buttonHeight,
                            ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
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

class BrailleKey extends StatelessWidget {
  final int value;
  final double size;
  final void Function(String) onTap;

  const BrailleKey(
      {Key? key, required this.value, required this.onTap, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(value.toString()),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 50),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Colors.white,
        ),
        child: Text(
          value.toString(),
          style: TextStyle(fontSize: size / 4, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
