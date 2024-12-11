import 'package:flutter/material.dart';

import '../../core/assets.dart';
import '../../core/constent.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: const BoxDecoration(
        color: kcolorc3,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Image.asset(
            AssetsData.logo,
            width: 90,
          ),
          Ktitle
        ],
      ),
    );
  }
}
