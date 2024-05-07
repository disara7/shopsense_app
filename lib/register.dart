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
        'Welcome to shopsense! My name is shopzee and I am here to assist you choose the clothing items you desire. To get started, let\'s first get to know each other. What\'s your name?');
  }

  Future<void> speakSentence(String sentence) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(0.9);
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

  void speakAnotherSentence() async {
    // Speak another sentence after the listening part
    await Future.delayed(
        Duration(seconds: 1)); // Delay for 1 second before speaking
    speakSentence("Thank you for providing your name.");
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
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20.0),
                      backgroundColor: Colors.pink[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      minimumSize: const Size(
                          double.infinity, 0), // Set minimum size to fill width
                    ),
                    child: const Text('Button 1'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20.0),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      minimumSize: const Size(
                          double.infinity, 0), // Set minimum size to fill width
                    ),
                    child: const Text('Button 2'),
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
