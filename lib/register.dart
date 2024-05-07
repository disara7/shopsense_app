import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:shopsense_app/shop.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  FlutterTts flutterTts = FlutterTts();
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  late Timer _timer;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    speakSentence(
        'Helooo Jane! congratulations on successfully setting up your shopsense profile, and welcome to the shopsense store! Please describe what kind of a clothing item you are looking for, today. After you describe, I will come up with a few clothes that match your description and if the item i describe matches your desire, please tap on the top right corner of the screen to get more details about purchasing and all. Or, if you want to hear about the other options you have tap on the bottom right corner of the screen. if you want to go back to the previous item, tap on the bottom left corner of the screen, AND if you want me to repeat what i just said, you can tap on the top left corner of the screen.');
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10), // Adjust the duration as needed
    )..repeat();
  }

  Future<void> speakSentence(String sentence) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(1.0);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(2.0);
    await flutterTts.setVoice({"name": "Karen", "locale": "en-AU"});
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
                          'Helooo Jane! congratulations on successfully setting up your shopsense profile, and welcome to the shopsense store! Please describe what kind of a clothing item you are looking for, today. After you describe, I will come up with a few clothes that match your description and if the item i describe matches your desire, please tap on the top right corner of the screen to get more details about purchasing and all. Or, if you want to hear about the other options you have tap on the bottom right corner of the screen. if you want to go back to the previous item, tap on the bottom left corner of the screen, AND if you want me to repeat what i just said, you can tap on the top left corner of the screen.');
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
                          "Of course, you can say it again. Please tap on the top half of the screen if you are sure you want to continue, or you can always reanswer by tapping on the bottom half of the screen.");
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
                'images/shopz.png',
                width: MediaQuery.of(context).size.width / 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
