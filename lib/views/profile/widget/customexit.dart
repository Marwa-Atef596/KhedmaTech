import 'package:flutter/material.dart';

import '../../../core/constent.dart';

// ignore: camel_case_types, must_be_immutable
class customexit extends StatelessWidget {
  customexit({
    super.key,
    this.txt,
    required this.icon,
    this.onTap,
  });
  String? txt;
  final IconData icon;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: kbc7,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.red,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              txt!,
              style: txtstyle6,
            )
          ],
        ),
      ),
    );
  }
}
