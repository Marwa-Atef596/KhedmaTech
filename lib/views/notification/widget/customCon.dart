import 'package:flutter/material.dart';
import '../../../core/constent.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
          color: kcolorc3, // Background color
          borderRadius: BorderRadius.circular(16), // Rounded corners
        ),
        padding: const EdgeInsets.all(20), // Padding for content
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                color:
                    Colors.green, // Background color of the circular container
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(10), // Padding for the icon
              child: const Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16), // Spacing between icon and text
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title', style: txtstyle11),
                SizedBox(height: 8), // Spacing between title and subject
                Text('Subject', style: txtstyle3),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
