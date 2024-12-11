import 'package:flutter/material.dart';
import 'package:khedma_tech/core/constent.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
          color: kcolorc3, // Background color
          borderRadius: BorderRadius.circular(16), // Rounded corners
        ),
        padding: EdgeInsets.all(20), // Padding for content
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color:
                    Colors.green, // Background color of the circular container
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(10), // Padding for the icon
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 16), // Spacing between icon and text
            Column(
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
