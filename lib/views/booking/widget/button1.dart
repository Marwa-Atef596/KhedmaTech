import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton1Booking extends StatelessWidget {
  CustomButton1Booking({
    this.backgroundColor,
    this.onPressed,
    this.text,
    super.key,
  });
  Color? backgroundColor;
  String? text;
  void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: Text(text!));
  }
}
