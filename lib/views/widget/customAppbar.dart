import 'package:flutter/material.dart';
import 'package:khedma_tech/core/assets.dart';
import 'package:khedma_tech/core/constent.dart';

// ignore: must_be_immutable
class CstomAppBar extends StatelessWidget {
  CstomAppBar({super.key, this.txt});
  String? txt;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          txt!,
          style: txtstyle2,
        ),
        const SizedBox(
          width: 16,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Image(
            image: AssetImage(AssetsData.icon),
            height: 60,
          ),
        )
      ],
    );
  }
}
