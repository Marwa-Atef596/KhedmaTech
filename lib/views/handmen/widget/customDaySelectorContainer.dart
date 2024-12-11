import 'package:flutter/material.dart';

import 'customDayContainer.dart';
class DaySelectorContainer extends StatefulWidget {
  const DaySelectorContainer({super.key});

  @override
  _DaySelectorContainerState createState() => _DaySelectorContainerState();
}

class _DaySelectorContainerState extends State<DaySelectorContainer> {
  final List<Map<String, dynamic>> _days = [
    {'name': 'السبت', 'number': 1},
    {'name': 'الاحد', 'number': 2},
    {'name': 'الاثنين', 'number': 3},
    {'name': 'الثلاثاء', 'number': 4},
    {'name': 'الاربعاء', 'number': 5},
    {'name': 'الخميس', 'number': 6},
    {'name': 'الجمعه', 'number': 7},
  ];
  int _selectedDayIndex = 0;

  void _selectDay(int index) {
    setState(() {
      _selectedDayIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70, // Adjust the height as needed
      child: ListView.builder(
        reverse: true,
        scrollDirection: Axis.horizontal,
        itemCount: _days.length,
        itemBuilder: (context, index) {
          return DayContainer(
            name: _days[index]['name'],
            number: _days[index]['number'],
            isSelected: _selectedDayIndex == index,
            onTap: () => _selectDay(index),
          );
        },
      ),
    );
  }
}
