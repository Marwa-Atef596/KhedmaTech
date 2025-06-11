import 'package:flutter/material.dart';

import '../../../core/assets.dart';
import '../../../core/constent.dart';
import 'custom_worl.dart';

class customgrid extends StatefulWidget {
   _customgridState c=_customgridState();
   customgrid({super.key});

  @override
  State<customgrid> createState() {

    return c;

  }
}

class _customgridState extends State<customgrid> {

  List ServiceName = [
    'كهرباء',
    'سباكه',
    'نجاره',
    'نظافة',
    'تكييفات',
    'دهانات',
    'ستايلات'
  ];
  List<Color> colors = [
    kbc1,
    kbc4,
    kbc2,
    kbc5,
    kbc6,
    kbc3,
    kbc7,
  ];
  List<Color> colors2 = [
    kbc11,
    kbc44,
    kbc22,
    kbc55,
    kbc66,
    kbc33,
    kbc77,
  ];
  List<String> imgs = [
    AssetsData.img1,
    AssetsData.img3,
    AssetsData.img2,
    AssetsData.img5,
    AssetsData.img6,
    AssetsData.img4,
    AssetsData.img7,
  ];
  static int  _selectedDayIndex = 0;
 static int getSomeIntValue() {
    return _selectedDayIndex;
  }
  void _selectDay(int index) {
    setState(() {
      _selectedDayIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = ServiceName.length;
    const maxCrossAxisCount = 2;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          crossAxisCount:
              itemCount <= maxCrossAxisCount ? itemCount : maxCrossAxisCount,
          childAspectRatio: 1.5),
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        if (index == itemCount - 1) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 40,
                right: 40,
                bottom: 16,
              ),
              child: CustomWork(
                //   isSelected: _selectedDayIndex == index,
                onTap: () => _selectDay(index),
                borderRadius: BorderRadius.circular(8),
                color:
                    _selectedDayIndex == index ? colors2[index] : colors[index],
                image: imgs[index],
                txt: ServiceName[index],
              ),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, bottom: 16),
            child: CustomWork(
              //   isSelected: _selectedDayIndex == index,
              onTap: () => _selectDay(index),
              borderRadius: BorderRadius.circular(8),
              color:
                  _selectedDayIndex == index ? colors2[index] : colors[index],
              image: imgs[index],
              txt: ServiceName[index],
            ),
          );
        }
        //bool isselect;
      },
    );
  }
}
