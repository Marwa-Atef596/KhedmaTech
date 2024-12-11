import 'package:flutter/material.dart';

import '../../../core/constent.dart';

class RatingRewie extends StatelessWidget {
  const RatingRewie({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.star_border_sharp,
          color: krate,
          size: 32,
        ));
  }
}
