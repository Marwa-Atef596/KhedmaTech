import 'package:flutter/material.dart';
import '../../core/assets.dart';
import '../../core/constent.dart';
import '../widget/customAppbar.dart';
import '../widget/customTxtFild.dart';
import 'widget/custom_btn_log.dart';

class Password extends StatelessWidget {
   Password(this. text, {super.key});
  var text="";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CstomAppBar(
                  txt: 'هل نسيت كلمة السر',
                ),
                const SizedBox(
                  height: 50,
                ),
                Image.asset(AssetsData.imgawepass),
                const SizedBox(
                  height: 50,
                ),
                const Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    maxLines: 2,
                    textAlign: TextAlign.right,
                    'اعاده تعيين كلمة السر عن طريق ارسال\nرمز تأكيد الى هاتفك',
                    style: txtstyle3,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTxtFild(
                  txt: 'رقم الهاتف',
                ),
                const SizedBox(
                  height: 70,
                ),
                CustomBtnLog(
                  title: 'ارسل الكود',
                  backgroundColor: kcolor1,
                  onPressed: () {
                    if(text.contains("+20"))
                      {

                      }
                    else
                      {

                      }
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Verfiy(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const NewPass(),
                              ),
                            );
                          },
                        ),
                      ),
                    );*/
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
