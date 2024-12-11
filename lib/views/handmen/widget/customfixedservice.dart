

import 'package:flutter/material.dart';

import '../../../core/constent.dart';

// ignore: camel_case_types
class customfixedservice extends StatelessWidget {
  const customfixedservice({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Text(
          '٥٠ ج.م',
          style: txtstyle2,
        ),
        Text(
          '  (للمعاينة)',
          style: TextStyle(fontSize: 16),
        )
      ],
    );
  }
}