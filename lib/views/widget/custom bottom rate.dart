
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constent.dart';
import '../search page.dart';

class custombottomrate extends StatefulWidget {
  const custombottomrate({
    super.key,
    required this.RatingNames,
  });

  final List RatingNames;

  @override
  State<custombottomrate> createState() => _custombottomrateState(RatingNames);
}

class _custombottomrateState extends State<custombottomrate> {
  int? _selectedIndex=0;
  final MyController myController = Get.put(MyController());

  _custombottomrateState(this. RatingNames)
  {
    print(RatingNames);
    print("RATING RATING");
  }
  final List RatingNames;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        shrinkWrap: true,
        reverse: true,
        scrollDirection: Axis.horizontal,
        // physics: NeverScrollableScrollPhysics(),
        itemCount: RatingNames.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                  myController.updateVariable4(index);
                });
              },
              child: Container(
                width: 70,
                // height: 26,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: kcolor1),
                  color: _selectedIndex == index ? kcolor1 : Colors.white,
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      Text(
                        "${RatingNames[index]}",
                        style: txtstyle1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
