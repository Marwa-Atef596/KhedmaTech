import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/constent.dart';

class TimePickerContainer extends StatefulWidget {
  const TimePickerContainer({super.key});

  @override
  _TimePickerContainerState createState() => _TimePickerContainerState();
}

class _TimePickerContainerState extends State<TimePickerContainer> {
  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _selectTime(context);
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: 100,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: kcolor1)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedTime.format(context),
                style: txtstyle1,
              ),
              const Icon(
                FontAwesomeIcons.chevronDown,
                color: kcolor1,
                size: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
