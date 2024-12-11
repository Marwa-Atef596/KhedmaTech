

import 'package:flutter/material.dart';

import '../../../core/constent.dart';

// ignore: camel_case_types, must_be_immutable
class customrowservice extends StatelessWidget {
  customrowservice({super.key, this.txtt});
  String? txtt;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          txtt!,
          style: txtstyle414,
        ),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_outline,
              color: ksmry,
              size: 32,
            ))
      ],
    );
  }
}
