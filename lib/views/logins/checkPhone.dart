import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../core/assets.dart';
import '../../core/constent.dart';
import 'verfication.dart';
import 'package:get/get.dart';
import '../widget/customAppbar.dart';
import '../widget/customTxtFild.dart';
import 'widget/custom_btn_log.dart';

class CheckPhoneNum extends StatelessWidget {
  String? name;
  String? phone;
  String? useremail;
  String? password;
  String? national_id;
  String? work;
  TextEditingController controller = TextEditingController();
  CheckPhoneNum(String name, String phone, String useremail, String password,
      String national_id, String work,
      {super.key}) {
    print(work);
    this.name = name;
    this.phone = phone;
    this.useremail = useremail;
    this.password = password;
    this.national_id = national_id;
    this.work = work;
    controller.text = this.phone!;
    print("******************************");
    print(controller.text);
  }

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
                  txt: 'التحقق من رقم الهاتف',
                ),
                const SizedBox(
                  height: 20,
                ),
                Image.asset(
                  AssetsData.img,
                ),
                Container(
                  width: 250,
                  height: 0.8,
                  color: const Color(0xffB5B5B5),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'التحقق من رقم الهاتف عن طريق ارسال \n رمز تأكيد الى هاتفك',
                      style: txtstyle3,
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomTxtFild(
                  keyboardType: TextInputType.phone,
                  prefixIcon: Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: const Text(
                      "+20",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  controller: controller,
                  txt: 'رقم الهاتف',
                ),
                const SizedBox(
                  height: 60,
                ),
                CustomBtnLog(
                  title: 'ارسال الكود',
                  backgroundColor: kcolor1,
                  onPressed: () async {
                    print("<<<<${controller.text.length}");
                    if (controller.text.substring(3).length != 10) {

                      Get.snackbar(
                          "Error", "الرجاء ادخال رقم هاتف مكون من 10 ارقام",
                          backgroundColor: Colors.blue);

                    } else {
                      Get.snackbar(
                          "Notification", "جار إرسال كود التفعيل",
                          backgroundColor: Colors.blue);
                      print("*///////////////////");
                      print(phone);
                      await Future.delayed(const Duration(seconds: 3), () async {
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: phone!,
                          timeout: const Duration(seconds: 60),
                          verificationCompleted:
                              (PhoneAuthCredential phoneAuthCredential) {
                            // Auto-resolving SMS code (this could happen when the phone number
                            // is already verified on this device)
                            print("Verification completed automatically");

                            // Optionally, you can sign in the user directly if you want
                            // await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
                          },
                          verificationFailed:
                              (FirebaseAuthException authException) {
                            // Handle error when verification fails
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Error"),
                                    content: Text("${authException.message}"),
                                  );
                                });

                            // Optionally, show an error message to the user
                          },
                          codeSent: (String verificationId,
                              int? forceResendingToken) {
                            // Handle when the code is sent

                            Get.to(Verfiy(
                              phone: phone,
                              national_id: national_id,
                              name: name,
                              password: password,
                              verification_id: verificationId,
                              work: work,
                            ));

                            // Store the verificationId for later use to verify the code
                            // You can also use forceResendingToken to resend the code if needed
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {
                            // Handle when the code auto retrieval times out
                            print("Code auto-retrieval timeout");
                            // Optionally, notify the user to enter the code manually
                          },
                        );
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
