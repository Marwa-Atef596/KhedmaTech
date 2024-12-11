import 'package:flutter/material.dart';

import '../../../core/constent.dart';

// ignore: must_be_immutable
class CustomTxtArea extends StatelessWidget {
  CustomTxtArea({super.key, this.txt});
  String? txt;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              txt!,
              style: txtstyle1,
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          textAlign: TextAlign.right,
          minLines: 6,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: kcolor1, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: kcolor1, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            alignLabelWithHint: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            // labelText: 'Enter text',
          ),
        ),
      ],
    );
  }
}
