import 'package:flutter/material.dart';

import '../booking/widget/button1.dart';
import '../widget/customAppService.dart';
class Privecy extends StatelessWidget {
  const Privecy({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            customAppService(
              txxt: 'حدد موقعك',
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 90 / 100,
                      height: MediaQuery.of(context).size.height * 60 / 100,
                      child: const Text(""),

                    ),
                    CustomButton1Booking(
                        backgroundColor: Colors.blue,
                        text: "حدد موقعك",
                        onPressed: () {}),
                    const Text("")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
