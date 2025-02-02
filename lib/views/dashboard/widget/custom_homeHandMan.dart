import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khedma_tech/views/dashboard/alldash.dart';
import 'package:khedma_tech/views/dashboard/comleteDash.dart';
import 'package:khedma_tech/views/dashboard/farwarddash.dart';
import 'package:khedma_tech/views/dashboard/rejectdash.dart';
import 'package:khedma_tech/views/dashboard/waitdash.dart';
import 'package:khedma_tech/views/dashboard/widget/allrecommend.dart';
import 'package:khedma_tech/views/dashboard/widget/customcontroller.dart';
import 'package:khedma_tech/views/notification/noNotify.dart';
import 'package:khedma_tech/views/profile/profile.dart';
import 'package:khedma_tech/views/widget/custom_handman.dart';

import '../../../core/assets.dart';
import '../../../core/constent.dart';
import '../../widget/custom_address.dart';
import '../../widget/custom_notify.dart';
import 'Customcustomsammry.dart';

class HomeHandMan extends StatelessWidget {
  const HomeHandMan({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomNotify(
                      icon: FontAwesomeIcons.person,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Profile("handman"),
                          ),
                        );
                      },
                    ),
                    const Text(
                      'لوحة التحكم',
                      style: txtstyle2,
                    ),
                    CustomNotify(
                      icon: FontAwesomeIcons.bell,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NoNotify(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Text(
                      'اهلا,',
                      style: txtstyle2,
                    ),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("handman")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        if (snapshot.hasError) {
                          return Text("has error");
                        }
                        if (!snapshot.hasData || !snapshot.data!.exists) {
                          print(FirebaseAuth.instance.currentUser!.uid);
                          return Text("No user");
                        }
                        return Text(
                          snapshot.data!.get("name"),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlue,
                              fontSize: 20),
                        );
                      },
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Image.asset(AssetsData.welcome, width: 45),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomController(
                      txt: 'كل الخدمات',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AllDash(),
                          ),
                        );
                      },
                    ),
                    CustomController(
                      txt: 'الخدمات المكتملة',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CompleteDash("completed"),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomController(
                      txt: 'الخدمات الملغية',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RejectDash("canceled"),
                          ),
                        );
                      },
                    ),
                    CustomController(
                      txt: 'الخدمات القادمة',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FarwardDash("forward"),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                const SizedBox(
                  height: 16,
                ),
                const Divider(
                  thickness: 2,
                  color: kbook,
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'التقييم والمراجعات',
                        style: txtstyle11,
                      ),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomAdderss(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AllRecommend(),
                                  ),
                                );
                              },
                              txt: '',
                            ),
                            /* customtxtrate(
                                FirebaseAuth.instance.currentUser!.uid)*/
                          ],
                        ),
                      ),
                      StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("handman")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasError) {
                            return Text("Error");
                          }
                          if (snapshot.hasData == false ||
                              snapshot.data!.exists == false) {
                            return Text("No user");
                          }

                          List ranks = snapshot.data!["ranks"];
                          print("<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>");

                          if (ranks.isEmpty)
                            return Container(
                              height:
                                  MediaQuery.of(context).size.height * 20 / 100,
                              child: Center(
                                child: Text("لا يوجد تقييمات"),
                              ),
                            );
                          return Container(
                            height:
                                MediaQuery.of(context).size.height * 60 / 100,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: const BoxDecoration(
                                                color: background,
                                                shape: BoxShape.circle),
                                            width: 100,
                                            child: Image.asset(
                                              'assets/images/11.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          StreamBuilder(
                                            stream: FirebaseFirestore.instance
                                                .collection("users")
                                                .doc(ranks[index]["owner"])
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }
                                              if (snapshot.hasError) {
                                                return Text("Error");
                                              }
                                              if (snapshot.hasData == false ||
                                                  snapshot.data!.exists ==
                                                      false) {
                                                return Text("No user");
                                              }

                                              return Container(child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,

                                                children: [
                                                  Text(snapshot.data!["name"],style: TextStyle(fontWeight: FontWeight.bold),),
                                                  Text(ranks[index]["comment"],overflow: TextOverflow.ellipsis,maxLines: 2,)
                                                ],
                                              ),width: MediaQuery.of(context).size.width*40/100,);
                                            },
                                          ),
                                          const Spacer(),
                                          Container(
                                            width: 60,
                                            // height: 26,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                              border:
                                                  Border.all(color: kcolor1),
                                              color: Colors.white,
                                            ),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                    '${ranks[index]["value"]}',
                                                    //  widget.RatingNames[index],
                                                    style: txtstyle1,
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                    ],
                                  ),
                                );
                              },
                              itemCount: ranks.length,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
