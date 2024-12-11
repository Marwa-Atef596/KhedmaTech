import 'package:flutter/material.dart';

import '../../../core/constent.dart';

// ignore: must_be_immutable
class CustomInfoService extends StatelessWidget {
  CustomInfoService({super.key, this.iconData, this.text});
  String? text;
  IconData? iconData;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: ksmry,
          size: 24,
        ),
        const SizedBox(
          width: 20,
        ),
        SizedBox(
            width: 85,
            child: Text(
              text!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ))
      ],
    );
  }
}
