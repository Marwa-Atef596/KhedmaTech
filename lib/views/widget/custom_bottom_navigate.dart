import 'package:flutter/material.dart';
import 'package:khedma_tech/core/constent.dart';

// ignore: must_be_immutable
class CustomBottomNavigationBar extends StatelessWidget {
  CustomBottomNavigationBar(
      {super.key, this.onTap, required this.currentIndex,required this.items,});
  void Function(int)? onTap;
  final int currentIndex;
  List<BottomNavigationBarItem> items;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        showUnselectedLabels: true,
        selectedItemColor: kcolor1,
        unselectedItemColor: kcolor2icon,
        iconSize: 30,
        mouseCursor: SystemMouseCursors.click,
        unselectedLabelStyle: const TextStyle(color: kcolor2icon),
        currentIndex: currentIndex,
        onTap: onTap,
        items: items);
  }
}
