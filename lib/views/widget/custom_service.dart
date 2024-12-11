import 'package:flutter/material.dart';

import '../../core/constent.dart';

// ignore: must_be_immutable
class CustomService extends StatelessWidget {
  CustomService(
      {super.key,
      required this.ServiceName,
      required this.colors,
      required this.imgs,
      this.onTap,
      this.reverse = false});

  // ignore: non_constant_identifier_names
  final List ServiceName;
  final List<Color> colors;
  final List<String> imgs;

  void Function(int)? onTap;
  bool reverse;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      reverse: reverse,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 1.1),
      itemCount: ServiceName.length,
      itemBuilder: (BuildContext context, int index) {
        // ignore: unused_local_variable
        final item = ServiceName[index];
        return Column(
          children: [
            GestureDetector(
              onTap:()=> onTap!(index),
              child: Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: colors[index],
                  ),
                  child: Center(
                      child: Image.asset(
                    imgs[index],
                    width: 40,
                  ))),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              ServiceName[index],
              style: txtstyle1,
              maxLines: 2,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        );
      },
    );
  }
}
