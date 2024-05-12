import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:shopsense_app/shop.dart';
import 'dart:io';

class Close extends StatefulWidget {
  const Close({Key? key}) : super(key: key);

  @override
  _CloseState createState() => _CloseState();
}

class _CloseState extends State<Close> with SingleTickerProviderStateMixin {
  FlutterTts flutterTts = FlutterTts();
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  late Timer _timer;
  late AnimationController _controller;

  @override
  // void initState() {
  //   super.initState();
  //   speakSentence(
  //       'To continue, lets first get to know each other. whats your name? After saying your name, please tap on the top half of the screen to go shopping with me or tap on the bottom half of the screen to do over.');

  //   _controller = AnimationController(
  //     vsync: this,
  //     duration: const Duration(seconds: 3), // Adjust the duration as needed
  //   )..repeat();
  // }

  Future<void> speakSentence(String sentence) async {
    await flutterTts.setLanguage('locale.UK');
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
    await flutterTts.setVoice({"name": "Karen", "locale": "en-UK"});
    await flutterTts.speak(sentence);
  }

  void startListening() {
    setState(() {
      _isListening = true;
    });

    _speech.listen(onResult: (result) {
      setState(() {
        _isListening = false;
        String inputText = result.recognizedWords;
        print(inputText);
        speakSentence("Hi $inputText");
        _timer.cancel(); // Cancel timer when speech is recognized
      });
    });

    _timer = Timer(const Duration(seconds: 5), () {
      stopListening();
    });
  }

  void stopListening() {
    setState(() {
      _isListening = false;
    });
    _speech.stop();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      speakSentence(
                          'Sure, lets go shopping! Describe to me what you wish to shop next.');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Shop(
                                  title: '',
                                )),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20.0),
                      backgroundColor: Colors.pink[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      minimumSize: const Size(
                          double.infinity, 0), // Set minimum size to fill width
                    ),
                    child: const Text(''),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      speakSentence(
                          "See you soon. The app will now be closed.");
                      exit(0);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20.0),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      minimumSize: const Size(
                          double.infinity, 0), // Set minimum size to fill width
                    ),
                    child: const Text(''),
                  ),
                ),
              ],
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: _controller.value * 2 * 3.1415,
                child: child,
              );
            },
            child: Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/shopz.png',
                width: MediaQuery.of(context).size.width / 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
