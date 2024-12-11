import 'package:flutter/material.dart';

// ignore: must_be_immutable, camel_case_types
class custombutton2 extends StatelessWidget {
  custombutton2({
    super.key,
    this.backgroundColor,
    this.onPressed,
    this.text,
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
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        onPressed: onPressed,
        child: Text(text!));
  }
}
