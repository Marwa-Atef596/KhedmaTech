import 'package:flutter/material.dart';
import 'package:khedma_tech/core/constent.dart';

import '../booking/widget/button1.dart';
import '../widget/customAppService.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 90 / 100,
                      child: Text(""),
                      height: MediaQuery.of(context).size.height * 60 / 100,

                    ),
                    CustomButton1Booking(
                        backgroundColor: Colors.blue,
                        text: "حدد موقعك",
                        onPressed: () {}),
                    Text("")
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
