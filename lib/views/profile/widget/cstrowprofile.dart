import 'package:flutter/material.dart';

import '../../../core/constent.dart';

// ignore: must_be_immutable
class Cstrowprofile extends StatelessWidget {
  Cstrowprofile({
    this.onPressed,
    super.key,
    required this.icon,
    required this.txt,
  });

  final IconData? icon;
  final String? txt;
  void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
            onPressed: onPressed,
            icon: Icon(
              icon,
              color: ksmry,
            )),
        txt!=null?Text(
          txt!,
          style: txtstyle6,
        ):const Text("")
      ],
    );
  }
}
