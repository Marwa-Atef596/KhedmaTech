import 'package:flutter/material.dart';

import '../../core/constent.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      required PageController pageController,
      this.title,
      this.onPressed})
      : _pageController = pageController;

  // ignore: unused_field
  final PageController _pageController;
  String? title;
  void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: kcolor1,
        ),
        onPressed: onPressed,
        child: Text(
          title!,
          style: const TextStyle(
              fontWeight: FontWeight.w700, fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
