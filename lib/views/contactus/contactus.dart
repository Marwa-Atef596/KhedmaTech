import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khedma_tech/core/constent.dart';
import 'package:khedma_tech/views/Rate%20&%20Review/widget/customdialograte.dart';
import 'package:khedma_tech/views/Rate%20&%20Review/widget/customtxtarea.dart';
import 'package:khedma_tech/views/logins/widget/custom_btn_log.dart';
import 'package:khedma_tech/views/widget/customTxtFild.dart';

import '../widget/customAppService.dart';

class ContactUs extends StatelessWidget {
  String? uid;

   ContactUs(String? this.uid, {super.key});
   TextEditingController question=new TextEditingController();
  TextEditingController name=new TextEditingController();
  TextEditingController phone=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              customAppService(
                txxt: 'تواصل معنا',
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'عندك سؤال او محتاج مساعدة ؟',
                style: txtstyle444,
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'تواصل معنا في اي وقت',
                style: txtstyle6,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTxtFild(
                controller: name,
                txt: '*الاسم',
              ),
              CustomTxtFild(
                controller: phone,
                txt: '*رقم الهاتف',
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "أكتب سؤالك*",
                        style: txtstyle1,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: question,
                    textAlign: TextAlign.right,
                    minLines: 6,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: kcolor1, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: kcolor1, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      // labelText: 'Enter text',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              CustomBtnLog(
                onPressed: () {
                  try
                  {
                    FirebaseFirestore.instance.collection("contact_us").doc().set({
                      "name": name.text ,
                      "phone": phone.text,
                      "question": question.text,
                      "owner":FirebaseAuth.instance.currentUser!.uid
                    });
                    showDialog(
                        context: context,
                        builder: (context) {
                          return DialogRate(

                            txt: 'تم ارسال استفسارك',
                          );
                        });
                  }
                  catch (e)
                  {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return DialogRate(
                            txt: 'Error',
                          );
                        });
                  }

                },
                title: 'ارسال',
                backgroundColor: kcolor1,
              )
            ],
          ),
        ),
      ),
    ));
  }
}
