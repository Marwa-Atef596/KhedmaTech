import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/constent.dart';
import '../../widget/customAppService.dart';
import 'Customcustomsammry.dart';

class AllRecommend extends StatelessWidget {
  const AllRecommend({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Expanded(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: customAppService(
                  txxt: 'كل المراجعات',
                ),
              ),
              // const SizedBox(
              //   height: 16,
              // ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: StreamBuilder<DocumentSnapshot>(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
