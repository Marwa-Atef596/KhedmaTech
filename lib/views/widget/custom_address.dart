import 'package:flutter/material.dart';

import '../../core/constent.dart';

// ignore: must_be_immutable
class CustomAdderss extends StatelessWidget {
  CustomAdderss({
    super.key,
    this.txt,
    this.onPressed,
  });
  String? txt;
  void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.arrow_back,
                  color: kcolor1,
                  size: 32,
                )),
            const Text(
              'عرض الكل',
              style: txtstyle6,
            ),
          ],
        ),
        Text(
          txt!,
          style: txtstyle11,
        ),
      ],
    );
  }
}
