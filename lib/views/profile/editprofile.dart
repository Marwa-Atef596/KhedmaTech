import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../core/constent.dart';
import '../booking/widget/custombotombokking.dart';
import 'widget/CustomListTile.dart';
import 'widget/customaddprofile.dart';
import 'widget/customexit.dart';

// ignore: must_be_immutable
class EditProfile extends StatelessWidget {
  String? type;

  EditProfile(String? uid, {super.key}) {
    type = uid;
  }
  List<String> addres = [
    'الاسم',
    'رقم الهاتف',
    'كلمة السر ',
    'العنوان',
    'البريد الالكتروني '
  ];
  List<String> sub = [
    'محمد سعيد',
    '010123456789',
    '********',
    'كفر الشيخ مساكن الزراعة بجوار سوبر ماركت المصطفى',
    'mohamedsaeed@gmail.com'
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: SingleChildScrollView(
              child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection(type!)
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || !snapshot.data!.exists) {
                    return const Text('Document does not exist');
                  } else {
                    return Column(
                      children: [
                        AddProfile(
                          txt: 'تعديل معلومات الحساب ',
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: addres.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == 0) {
                              return CustomListTile(
                                  text1: addres[index],
                                  text2: snapshot.data!.data()!["name"],
                                  filed: 'name',type:type!);
                            }
                            if (index == 1) {
                              return CustomListTile(
                                  text1: addres[index],
                                  text2: snapshot.data!.data()!["phone"],filed: 'phone',type:type!);
                            }
                            if (index == 2) {
                              return CustomListTile(
                                  text1: addres[index],
                                  text2: snapshot.data!.data()!["password"],filed: 'password',type:type!);
                            }
                            if (index == 3) {
                              return CustomListTile(
                                  text1: addres[index], text2: snapshot.data!.data()!["adresse"],filed: 'none',type:type!);
                            }

                            return CustomListTile(
                                text1: addres[index],
                                text2: snapshot.data!.data()!.containsKey("email")?snapshot.data!.data()!["email"]:"No email",filed: 'email',type:type!);
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          thickness: 2,
                          color: kbook,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: customexit(
                            onTap: () {
                              showModalBottomSheet(
                                showDragHandle: true,
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(24),
                                    topRight: Radius.circular(24),
                                  ),
                                ),
                                builder: (BuildContext context) {
                                  return BotomBokking(

                                    txt1: 'حذف حسابك',
                                    txt2: 'هل انت متأكد من حذف حسابك',
                                    txt3: 'نعم',
                                    txt4: 'لا',
                                   type:  type,
                                   data:   snapshot.data!.data()
                                    
                                  );
                                },
                              );
                            },
                            icon: Icons.delete,
                            txt: 'حذف حسابك',
                          ),
                        )
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
