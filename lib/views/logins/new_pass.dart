import 'package:flutter/material.dart';
import 'package:khedma_tech/views/widget/customAppbar.dart';
import 'package:khedma_tech/views/widget/customTxtFild.dart';

import '../../core/assets.dart';
import '../../core/constent.dart';
import 'widget/custom_btn_log.dart';
import 'widget/show_dialog.dart';

class NewPass extends StatelessWidget {
  const NewPass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CstomAppBar(
                txt: 'انشاء كلمة سر جديدة',
              ),
              const SizedBox(
                height: 200,
              ),
              CustomTxtFild(
                obscureText: true,
                txt: 'كلمة السر الجديدة',
                prefixIcon: const Icon(Icons.visibility_off),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTxtFild(
                  obscureText: true,
                  txt: 'تأكيد كلمة السر الجديدة',
                  prefixIcon: const Icon(Icons.visibility_off)),
              const SizedBox(
                height: 150,
              ),
              CustomBtnLog(
                title: 'انشاء كلمة السر',
                backgroundColor: kcolor1,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return ShowDialogg(
                          txt2: 'العوده لتسجيل الدخول',
                          image: AssetsData.imgawe2,
                          txt: 'تم تغيير كلمة السر بنجاح',
                        );
                      });
             
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
