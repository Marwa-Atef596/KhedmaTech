import 'package:flutter/material.dart';

import '../../../core/constent.dart';

// ignore: must_be_immutable
class CustomWork extends StatelessWidget {
  CustomWork({
    super.key,
    this.color,
    this.image,
    this.txt,
    this.borderRadius,
    this.onTap, 
    //required this.isSelected,
  });
//  final bool isSelected;
  Color? color;
  String? txt;
  String? image;

  BorderRadiusGeometry? borderRadius;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 98,
        height: 100,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 16,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: color,
          borderRadius: borderRadius,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              height: 3,
            ),
            Image.asset(
              image!,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              height: 6,
            ),
            Expanded(
              child: Text(
                txt!,
                style: txtstyle3,
              ),
            ),
            const SizedBox(
              height: 4,
            )
          ],
        ),
      ),
    );
  }
}
