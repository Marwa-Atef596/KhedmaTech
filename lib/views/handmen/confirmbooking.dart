import 'package:flutter/material.dart';
import 'package:khedma_tech/core/constent.dart';
import 'package:khedma_tech/views/Rate%20&%20Review/widget/customtxtarea.dart';
import 'package:khedma_tech/views/logins/widget/custom_btn_log.dart';
import '../../core/assets.dart';
import '../logins/widget/show_dialog.dart';
import '../widget/customAppService.dart';
import 'widget/customDaySelectorContainer.dart';
import 'widget/customMonthYearSelectorContainer.dart';
import 'widget/customTimePickerContainer.dart';

class ConfirmBooking extends StatelessWidget {
  const ConfirmBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: customAppService(
                    txxt: 'تفاصيل الحجز',
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                CustomTxtArea(
                  txt: 'اكتب عنوانك',
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'التاريخ والوقت',
                  style: txtstyle6,
                ),
                const SizedBox(
                  height: 20,
                ),
                const MonthYearSelectorContainer(),
                const SizedBox(height: 10),
                const DaySelectorContainer(),
                const SizedBox(height: 10),
                const Text(
                  'الساعة',
                  style: txtstyle6,
                ),
                const SizedBox(
                  height: 16,
                ),
                  const TimePickerContainer(),
                const SizedBox(
                  height: 30,
                ),
                CustomBtnLog(
                  title: 'تأكيد الحجز',
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return ShowDialogg(
                            image: AssetsData.imgawe,
                            txt: 'تم حجز خدمتك بنجاح',
                            txt2: 'تواصل مع الحرفي ',
                          );
                        });
                  },
                  backgroundColor: kcolor1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
