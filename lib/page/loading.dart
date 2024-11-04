import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:quizz/page/mainmenu.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  Future<void> _loadData() async {
    await Future.delayed(const Duration(seconds: 4));
    // Uncomment ini untuk simulasi error
    // throw Exception("Simulated error");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: FutureBuilder<void>(
        future: Future.delayed(
            const Duration(milliseconds: 500), () => _loadData()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoadingContent();
          } else if (snapshot.hasError) {
            return _buildErrorContent();
          } else {
            Future.delayed(const Duration(milliseconds: 2000), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MainMenu()),
              );
            });
            return _buildLoadingCompleteContent();
          }
        },
      ),
    );
  }

  Widget _buildLoadingContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildAnimatedText(),
          const SizedBox(height: 20),
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
          const SizedBox(height: 20),
          const Text(
            'Loading...',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingCompleteContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildAnimatedText(),
          const SizedBox(height: 20),
          const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 50.0,
          ),
          const SizedBox(height: 20),
          const Text(
            'Loading Complete!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildAnimatedText(),
          const SizedBox(height: 20),
          const Icon(
            Icons.close,
            color: Colors.red,
            size: 50.0,
          ),
          const SizedBox(height: 20),
          const Text(
            'There is a problem. Please try again later.',
            style: TextStyle(
              color: Colors.red,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedText() {
    return Container(
      alignment: Alignment.center,
      child: AnimatedTextKit(
        animatedTexts: [
          TypewriterAnimatedText(
            'UPP SKILL',
            textStyle: const TextStyle(
              fontSize: 50.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
