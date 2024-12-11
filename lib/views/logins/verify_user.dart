import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma_tech/views/dashboard/home_handman.dart';
import 'package:khedma_tech/views/logins/create_pass.dart';
import 'package:khedma_tech/views/logins/widget/Check_adress.dart';
import 'package:khedma_tech/views/logins/widget/show_dialog.dart';
import 'package:khedma_tech/views/widget/customAppbar.dart';
import 'package:khedma_tech/views/logins/widget/custom_btn_log.dart';
import 'package:pinput/pinput.dart';
import '../../core/assets.dart';
import '../../core/constent.dart';
import '../home_page.dart';
import 'widget/customVerfiy.dart';

// ignore: must_be_immutable
class verify_user extends StatelessWidget {
  verify_user(
      {super.key,
        this.name,
        this.phone,
        this.national_id,
        this.password,
        this.verification_id,
        });
  String? name;
  String? password;
  String? national_id;
  String? phone;
  String? verification_id;
  String otp = '';


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CstomAppBar(
                  txt: 'التحقق من رقم الهاتف',
                ),
                const SizedBox(
                  height: 250,
                ),
                Text(
                  ' ${phone}تم ارسال رمز التأكيد الى',
                  style: txtstyle3,
                ),
                const SizedBox(
                  height: 30,
                ),
                Pinput(
                  defaultPinTheme: PinTheme(
                      height: MediaQuery.of(context).size.height * 5 / 100,
                      width: MediaQuery.of(context).size.width * 15 / 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[400]),
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue)),
                  onCompleted: ((value) {
                    otp = value;
                  }),
                  length: 6,
                  showCursor: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: () {

                        },
                        child: const Text(
                          'اعاده ارسال',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: kcolor1),
                        )),
                    const Text(
                      '   لم يتم ارسال الكود ؟',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 190,
                ),
                CustomBtnLog(
                  title: 'تحقق من الكود',
                  backgroundColor: kcolor1,
                  onPressed: () async {
                    if (otp.length != 6) {

                      Get.snackbar("Error", "يرجى ادخال 6 أرقام");
                    } else {
                      try {

                        PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: this.verification_id!,
                            smsCode: otp);
                        UserCredential uc = await FirebaseAuth.instance
                            .signInWithCredential(credential);
                        print(uc);
                        if(uc!=null)
                          {
                            TextEditingController adresse = new TextEditingController();
                            Get.bottomSheet(isDismissible: false,BottomSheet(

                              onClosing: () {},
                              builder: (context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 50 / 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width*90/100,
                                        height: MediaQuery.of(context).size.height * 5 / 100,
                                        child: TextField(
                                          textDirection: TextDirection.rtl,


                                          controller: adresse,
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width*90/100,
                                        height: MediaQuery.of(context).size.height * 5 / 100,
                                        child: CustomBtnLog(
                                          onPressed: () async {
                                            if(adresse.text=="")
                                            {
                                              Get.snackbar("Error", "الرجاء ادخال عنوان",backgroundColor: Colors.blue);
                                            }
                                            else
                                            {

                                              Get.snackbar("Notification", "جار تسجيل حسابك");

                                              await Future.delayed(Duration(seconds: 3), () async {

                                                FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).set({
                                                  "name":this.name,
                                                  "phone":this.phone,
                                                  "email":"",
                                                  "password":this.password,
                                                  "national_id":this.national_id,
                                                  "favorites":[],
                                                  "adresse":adresse.text

                                                });
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return ShowDialogg(
                                                      image: AssetsData.imgawe,
                                                      txt: 'تم انشاء حسابك بنجاح',
                                                      txt2: 'العوده لتسجيل الدخول ',
                                                    );
                                                  },
                                                );

                                              });
                                            }
                                          },
                                          Txtcolor: Colors.black,
                                          side: BorderSide(width: 1),
                                          title: "ادخل العنوان",
                                          backgroundColor: Colors.blue,
                                        ),
                                      )

                                    ],
                                  ),
                                );
                              },
                            ));


                          }






                      } catch (e) {
                        if (e is FirebaseAuthException) {
                          print("***************************");
                          Get.snackbar("ERROR", e.code == "invalid-verification-code" ? "كود التفعيل خاطئ" : "",backgroundColor: Colors.blue);
                        }
                      }
                    }
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
