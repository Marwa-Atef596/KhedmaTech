

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khedma_tech/views/booking/widget/custombotombokking.dart';
import 'package:khedma_tech/views/contactus/contactus.dart';
import 'package:khedma_tech/views/contactus/privecy.dart';
import 'package:khedma_tech/views/profile/editprofile.dart';
import '../../core/constent.dart';
import '../RecommendedFavourites/Favourites.dart';
import 'widget/customappprofile.dart';
import 'widget/customcontainerprofile.dart';
import 'widget/customexit.dart';

class Profile extends StatefulWidget {
  String? uid;
   Profile(String? this.uid,  {super.key});



  @override
  State<Profile> createState() => _ProfileState(uid);
}

class _ProfileState extends State<Profile> {
  String? uid;
  _ProfileState(String? this.uid)
  {

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("///");
    print(FirebaseAuth.instance.currentUser!.uid);
  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance.collection(uid!).doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
              builder:(context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(),);
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || !snapshot.data!.exists) {
                  return Text('Document does not exist');
                } else {
                  // The document exists and we have data
                  var documentData = snapshot.data!.data();

                  return  Column(
                    children: [
                       customappprofile(uid),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        child: Column(
                          children: [
                             Text(
                              "${documentData!["name"]}",
                              style: txtstyle6,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                             Text(
                              "${documentData["email"]}",
                              style: TextStyle(color: background),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            customcontainerprofile(
                              txt: 'تعديل معلومات الحساب',
                              onPressed: () {

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditProfile( this.uid ,),
                                  ),
                                );
                              },
                              icon: FontAwesomeIcons.addressCard,
                              txt2: 'الحرفيين المفضليين',
                              onPressed2: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>  Favourites(),
                                  ),
                                );
                              },
                              icon2: FontAwesomeIcons.heart ,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              thickness: 2,
                              color: kbook,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            customcontainerprofile(
                              txt: 'تواصل معنا ',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>  ContactUs(this.uid),
                                  ),
                                );
                              },
                              icon: FontAwesomeIcons.headset,
                              txt2: 'سياسة الخصوصية',
                              onPressed2: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Privecy(),
                                  ),
                                );
                              },
                              icon2: FontAwesomeIcons.fileShield,
                            ),
                            const SizedBox(
                              height: 10,
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
                                        txt1: 'تسجيل الخروج',
                                        txt2: 'هل انت متأكد من تسجيل خروجك',
                                        txt3: 'نعم',
                                        txt4: 'لا',
                                      );
                                    },
                                  );
                                },
                                txt: 'تسجيل الخروج',
                                icon: FontAwesomeIcons.rightFromBracket,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }



                },
            ),
          ),
        ),
      ),
    );
  }
}
