
import 'package:flutter/material.dart';

import '../../../core/constent.dart';
class CustomVerfiy extends StatelessWidget {
  const CustomVerfiy({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: TextFormField(
        maxLength: 1,
          decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kcolor1, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kcolor1, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))))),
    );
  }
}
