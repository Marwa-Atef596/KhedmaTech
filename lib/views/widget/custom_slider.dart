
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../core/constent.dart';
import '../search page.dart';

class RangeSliderExample extends StatefulWidget {
   late RangeValues local;
   RangeSliderExample(RangeValues range, {super.key})
  {
this.local=range;
  }


  @override
  State<RangeSliderExample> createState() => _RangeSliderExampleState(local);
}

class _RangeSliderExampleState extends State<RangeSliderExample> {
 late  RangeValues _currentRangeValues;
 final MyController myController = Get.put(MyController());
  _RangeSliderExampleState(RangeValues local)
  {
    this._currentRangeValues=local;
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context)
          .copyWith(trackHeight: 10, overlayColor: Colors.transparent),
      child: RangeSlider(
        inactiveColor: background,
        activeColor: kcolor1,
        values: _currentRangeValues,
        max: 150,
        divisions: 15,
        labels: RangeLabels(
          _currentRangeValues.start.round().toString(),
          _currentRangeValues.end.round().toString(),
        ),
        onChanged: (RangeValues values) {
          setState(() {
            _currentRangeValues = values;
            myController.updateVariable2(values.start.toInt());
            myController.updateVariable3(values.end.toInt());

          });
        },
      ),
    );
  }
}