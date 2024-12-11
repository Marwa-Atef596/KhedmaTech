import 'package:flutter/material.dart';

import '../../../core/constent.dart';

class DayContainer extends StatelessWidget {
  final String name;
  final int number;
  final bool isSelected;
  final VoidCallback onTap;

  const DayContainer({
    super.key,
    required this.name,
    required this.number,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        //width: isSelected ? 80 : 65,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: kcolor1),

          //  color: isSelected ? kcolor1 : Colors.transparent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold,
                //color: kcolor1
                color: isSelected ? kcolor1 : background,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              '$number',
              style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold,
                color: isSelected ? kcolor1 : background,
                // color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
