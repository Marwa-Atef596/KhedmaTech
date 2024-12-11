import 'package:flutter/material.dart';

import '../../../core/constent.dart';

// ignore: must_be_immutable
class AddProfile extends StatelessWidget {
  AddProfile({
    this.txt,
    super.key,
  });
  String? txt;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
            onPressed: () {

            },
            icon: const Icon(
              Icons.arrow_back,
              color: kcolor1,
            )),
        Text(
          txt!,
          style: txtstyle2,
        ),
      ],
    );
  }
}
