import 'package:flutter/material.dart';
import '../../core/constent.dart';

import '../widget/handman_Booking_forward.dart';

class FarwardDash extends StatelessWidget {
 var  type="";
   FarwardDash(String s, {super.key}){
    type=s;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                'الخدمات القادمة',
                // style: txtstyle2,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 24),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: kcolor1,
                  )),
            ],
          ),
          backgroundColor: Colors.white.withOpacity(0.5),
          elevation: 0,
        ),
        body:  const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: handman_Booking_forward(),
        ));
  }
}
