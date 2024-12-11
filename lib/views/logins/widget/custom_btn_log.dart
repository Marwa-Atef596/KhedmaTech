import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomBtnLog extends StatelessWidget {
  CustomBtnLog(
      {super.key,
      this.title,
      this.onPressed,
      this.Txtcolor,
      this.backgroundColor,
      this.side});
  String? title;
  void Function()? onPressed;
  Color? backgroundColor;
  BorderSide? side;
  Color? Txtcolor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: backgroundColor,
          side: side,
        ),
        onPressed: onPressed,
        child: Text(
          title!,
          style: TextStyle(
              color: Txtcolor, fontWeight: FontWeight.w700, fontSize: 16),
        ),
      ),
    );
  }
}
