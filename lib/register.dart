import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  FlutterTts flutterTts = FlutterTts();
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    speakSentence(
        'Welcome to shopsense! My name is shopzee and I am here to assist you choose the clothing items you desire. To get started, let\'s first get to know each other. What\'s your name? Once you say your name, to continue, please tap on the top half of your screen, or if you want to redo, please tap on the bottom half of the screen.');
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
                          'Hello, Jane. Could you please tell me your phone number to set up the profile? Once you finish saying your phone number, please tap on the top half of the screen to continue, or if you want to redo, please tap on the bottom half of the screen.');
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
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.volume_up, color: Colors.white),
                  const SizedBox(width: 10),
                  Text('Voice Output', style: TextStyle(color: Colors.white)),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: Icon(Icons.mic),
                    color: Colors.white,
                    onPressed: () {
                      startListening();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
