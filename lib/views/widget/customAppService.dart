import 'package:flutter/material.dart';

import '../../core/constent.dart';

// ignore: camel_case_types, must_be_immutable
class customAppService extends StatelessWidget {
  customAppService({super.key, this.txxt});
  String? txxt;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          txxt!,
          style: txtstyle2,
        ),
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_forward,
              color: kcolor1,
              size: 28,
            ))
      ],
    );
  }
}
