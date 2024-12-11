import 'package:flutter/material.dart';

import '../../../core/constent.dart';
import '../../chat/chat_screen.dart';
import '../confirmbooking.dart';
import 'custombottomnavigationservice.dart';

class CustomBottomService extends StatelessWidget {
  const CustomBottomService({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              blurRadius: 0.8,
            ),
          ]),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BottomNavigationService(
            title: 'تواصل معي',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(),
                ),
              );
            },
            side: const BorderSide(color: kcolor1),
            backgroundColor: Colors.white,
            Txtcolor: kcolor1,
          ),
          const SizedBox(
            width: 20,
          ),
          BottomNavigationService(
            title: 'احجز الان',
            backgroundColor: kcolor1,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ConfirmBooking(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
