import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String? imageUrl;
  final String? title;

  const OnboardingPage({super.key, this.imageUrl, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imageUrl!,
          height: MediaQuery.of(context).size.height*50/100,
          width: MediaQuery.of(context).size.width*90/100,
          // fit: BoxFit.fil,
        ),
        const SizedBox(height: 25.0),
        SizedBox(child: Text(
          maxLines: 2,
          title!,
          style: const TextStyle(
            height: 2,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),),
      ],
    );
  }
}
