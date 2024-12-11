import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constent.dart';
import '../search page.dart';

class customlistviewbottom extends StatefulWidget {
   customlistviewbottom({
    super.key,
    required this.ServiceNames,
  })
  {
    print("INIT INIT");
    print(this.ServiceNames);
  }

  final List ServiceNames;

  @override
  State<customlistviewbottom> createState() => _customlistviewbottomState(ServiceNames);
}

class _customlistviewbottomState extends State<customlistviewbottom> {
  int? _selectedIndex=0;
  final MyController myController = Get.put(MyController());

  _customlistviewbottomState(this. ServiceNames);
  final List ServiceNames;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        shrinkWrap: true,
        reverse: true,
        scrollDirection: Axis.horizontal,
        // physics: NeverScrollableScrollPhysics(),
        itemCount: this.ServiceNames.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                  myController.updateVariable1(index);
                });
              },
              child: Container(
                width: 70,
                // height: 26,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: _selectedIndex == index ? kcolor1 : background),
                child: Center(
                  child: Text(
                    this.ServiceNames[index],
                    style: txtstyle66,
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
