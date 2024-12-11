import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/constent.dart';

class MonthYearSelectorContainer extends StatefulWidget {
  const MonthYearSelectorContainer({super.key});

  @override
  _MonthYearSelectorContainerState createState() =>
      _MonthYearSelectorContainerState();
}

class _MonthYearSelectorContainerState
    extends State<MonthYearSelectorContainer> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: 90,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            // border: Border.all(color: kcolor1)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_selectedDate.month.toString().padLeft(2, '0')}/${_selectedDate.year.toString()}',
                style: txtstyle1,
                // style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
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
