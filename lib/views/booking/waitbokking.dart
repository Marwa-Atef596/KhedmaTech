import 'package:flutter/material.dart';
import 'package:khedma_tech/views/booking/widget/button1.dart';

import '../../core/constent.dart';
import 'widget/CustomRowBokking.dart';
import 'widget/Customtextrow2.dart';
import 'widget/customVisibleContainer.dart';

class WaitBooking extends StatefulWidget {
  const WaitBooking({super.key});

  @override
  _WaitBookingState createState() => _WaitBookingState();
}

class _WaitBookingState extends State<WaitBooking> {
  bool isVisible = false;

  List<bool> itemExpandedList = List.generate(10, (index) => false);
  void Visability(int index) {
    setState(() {
      itemExpandedList[index] = !itemExpandedList[index];
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Container(
                margin: const EdgeInsets.only(left: 2, right: 2),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 0.8,
                      ),
                    ]),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    children: [
                      CustomRowBokking(
                        text: 'قيد الانتظار',
                        backgroundColor: const Color(0xff40A2D8),
                        width: 30,
                      ),
                      const Divider(
                        thickness: 2,
                        color: kbook,
                      ),
                      if (itemExpandedList[index])
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Customtextrow2(
                                  txt1: 'سعر المعاينة',
                                  txt2: '٥٠ ج.م (للمعاينة)',
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Customtextrow2(
                                  txt1: 'العنوان ',
                                  txt2: '١٢ شارع الجيش\n كفر-الشيخ',
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomButton1Booking(
                                      backgroundColor: Colors.green,
                                      text: 'الموافقة',
                                      onPressed: () {},
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    CustomButton1Booking(
                                      backgroundColor: Colors.red,
                                      text: 'الرفض',
                                      onPressed: () {},
                                    )
                                  ],
                                ),
                                const Divider(
                                  thickness: 2,
                                  color: kbook,
                                ),
                              ],
                            ),
                          ),
                        ),
                      GestureDetector(
                        onTap: () => Visability(index),
                        child: customVisibleContainer(isVisible: isVisible),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
