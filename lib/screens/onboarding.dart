import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FlutterLogo(size: 96),
              const SizedBox(height: 24),
              AnimatedTextKit(animatedTexts: [
                TypewriterAnimatedText('Welcome to SalesBets', textStyle: Theme.of(context).textTheme.headlineSmall!),
              ]),
              const SizedBox(height: 16),
              const Text(
                'Win but never lose — place bets using credits. You keep your staked credits regardless of outcome; wins add rewards to your wallet.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
                child: const Text('Get Started'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
