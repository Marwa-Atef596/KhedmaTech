
import 'package:flutter/material.dart';

import '../../../core/constent.dart';
import '../../widget/custom_handman.dart';

class customsercicenamerate extends StatelessWidget {
  const customsercicenamerate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        const Text(
          'عمر محمد',
          style: txtstyle1,
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: customtxtrate(""),
        )
      ],
    );
  }
}