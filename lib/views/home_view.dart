import 'package:flutter/material.dart';
import 'on_boarding.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: OnboardingScreen(),
      ),
    );
  }
}
