import 'package:flutter/material.dart';
import 'cstrowprofile.dart';

// ignore: camel_case_types, must_be_immutable
class customcontainerprofile extends StatelessWidget {
  customcontainerprofile({
    super.key,
    this.txt,
    this.icon,
    this.icon2,
    this.txt2,
    this.onPressed,
    this.onPressed2,
  });
  String? txt;
  IconData? icon;
  String? txt2;
  IconData? icon2;
  void Function()? onPressed;
  void Function()? onPressed2;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              blurRadius: 0.5,
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          children: [
            Cstrowprofile(
              icon: icon,
              txt: txt,
              onPressed: onPressed,
            ),
            Cstrowprofile(
              icon: icon2,
              txt: txt2,
              onPressed: onPressed2,
            ),
          ],
        ),
      ),
    );
  }
}
