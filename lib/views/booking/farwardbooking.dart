import 'package:flutter/material.dart';
import 'package:khedma_tech/core/constent.dart';
import 'package:khedma_tech/views/logins/widget/custom_btn_log.dart';

class FarwardBooking extends StatelessWidget {
  const FarwardBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'لا يوجد لديك حجوزات في الوقت الحالي ',
              style: txtstyle6,
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset('assets/images/Capture45-removebg-preview.png'),
            const SizedBox(
              height: 100,
            ),
            CustomBtnLog(
              title: 'احجز خدمتك دلوقتي',
              onPressed: () {},
              backgroundColor: kcolor1,
            )
          ],
        ),
      ),
    );
  }
}
