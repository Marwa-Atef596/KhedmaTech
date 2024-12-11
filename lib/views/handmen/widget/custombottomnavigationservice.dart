import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BottomNavigationService extends StatelessWidget {
  BottomNavigationService({
    super.key,
    // ignore: non_constant_identifier_names
    this.Txtcolor,
    this.backgroundColor,
    this.onPressed,
    this.side,
    this.title,
  });
  String? title;
  void Function()? onPressed;
  Color? backgroundColor;
  BorderSide? side;
  // ignore: non_constant_identifier_names
  Color? Txtcolor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
    );
  }
}
