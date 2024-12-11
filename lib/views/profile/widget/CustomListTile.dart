import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constent.dart';
import '../../logins/widget/custom_btn_log.dart';
import '../../widget/customTxtFild.dart';

class CustomListTile extends StatelessWidget {
  // final IconData icon;
  final String text1;
  final String text2;
  final String filed;
  final String type;
  TextEditingController change = new TextEditingController();
  CustomListTile({
    super.key,
    //  required this.icon,
    required this.text1,
    required this.text2,
    required this.filed,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.close,
                            color: kcolor1,
                          ),
                        ),
                        CustomTxtFild(
                          controller: change,
                          txt: 'تعديل ',
                        ),
                        CustomBtnLog(
                          onPressed: () async {
                            if (filed == "phone") {
                              if (FirebaseAuth.instance.currentUser!.email !=
                                  null) {
                                FirebaseFirestore.instance
                                    .collection(type)
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update({filed: change.text});
                                Navigator.of(context).pop();
                                Get.snackbar("Notification", "تم التغيير بنجاح",
                                    backgroundColor: Colors.blue);
                              } else {
                                // await FirebaseAuth.instance.currentUser!.updatePassword();
                              }
                            } else if (filed == "password") {



                              if (change.text.length < 6)
                                Get.snackbar("Notification", "password minimum 6 caracteres",
                                    backgroundColor: Colors.blue);
                              else {


                                FirebaseFirestore.instance
                                    .collection(type)
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update({filed: change.text});
                                Navigator.of(context).pop();
                                Get.snackbar("Notification", "تم التغيير بنجاح",
                                    backgroundColor: Colors.blue);

                              }
                            } else {
                              if (filed == "email") {
                                await FirebaseAuth.instance.currentUser!
                                    .updateEmail(change.text);

                                FirebaseFirestore.instance
                                    .collection(type)
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update({filed: change.text});
                                Navigator.of(context).pop();
                                Get.snackbar("Notification", "تم التغيير بنجاح",
                                    backgroundColor: Colors.blue);
                              } else {
                                FirebaseFirestore.instance
                                    .collection(type)
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update({filed: change.text});
                                Navigator.of(context).pop();
                                Get.snackbar("Notification", "تم التغيير بنجاح",
                                    backgroundColor: Colors.blue);
                              }
                            }
                          },
                          title: 'حفظ',
                          backgroundColor: kcolor1,
                        )
                      ],
                    ),
                  ),
                );
              });
        },
        icon: const Icon(
          Icons.edit,
          color: kcolor1,
        ),
      ),
      title: Text(
        text1,
        style: txtstyle6,
      ),
      subtitle: Text(text2),
    );
  }
}
