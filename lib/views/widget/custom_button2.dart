import 'package:flutter/material.dart';
import 'package:khedma_tech/core/constent.dart';

// ignore: must_be_immutable
class CustomButton2 extends StatelessWidget {
  CustomButton2(
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
          side: const BorderSide(color: kcolor1, width: 1),
          backgroundColor: const Color(0xffFAFAFA),
        ),
        onPressed: () {
          _pageController.previousPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        },
        child: Text(
          title!,
          style: const TextStyle(
              color: kcolor1, fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
