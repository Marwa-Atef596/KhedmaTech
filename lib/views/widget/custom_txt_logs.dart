import 'package:flutter/material.dart';

import '../../core/assets.dart';
import '../../core/constent.dart';

// ignore: must_be_immutable
class CustomTxtLogs extends StatelessWidget {
  CustomTxtLogs({super.key, this.title, this.txt});
  String? title;
  String? txt;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(AssetsData.welcome, width: 50),
            const SizedBox(
              width: 16,
            ),
            Text(
              txt!,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          title!,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: kcolor1,
          ),
          // textAlign: TextAlign.right,
        )
      ],
    );
  }
}
