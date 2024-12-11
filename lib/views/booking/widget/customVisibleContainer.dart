import 'package:flutter/material.dart';

import '../../../core/constent.dart';

class customVisibleContainer extends StatelessWidget {
  const customVisibleContainer({
    super.key,
    required this.isVisible,
  });

  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            color: kcolor1,
            size: 32,
            isVisible
                ? Icons.keyboard_arrow_up
                : Icons.keyboard_arrow_down,
          ),
        ],
      ),
    );
  }
}
