import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'widget/button1.dart';

import '../../core/constent.dart';
import '../Rate & Review/Rate & Review.dart';
import '../chat/chat_screen.dart';
import 'widget/customVisibleContainer.dart';

class CompleteBooking extends StatefulWidget {
  const CompleteBooking({super.key});

  @override
  CompleteBookingState createState() => CompleteBookingState();
}

class CompleteBookingState extends State<CompleteBooking>
    with AutomaticKeepAliveClientMixin {
  bool isVisible = false;
  @override
  bool get wantKeepAlive => true;
  List<bool> itemExpandedList = List.generate(10, (index) => false);
  void Visability(int index) {
    setState(() {
      itemExpandedList[index] = !itemExpandedList[index];
      isVisible = !isVisible;
    });
  }

  String type = "";
  Future<void> set_type() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("handman")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (doc.exists) {
      type = "handman";
    } else {
      type = "user";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    set_type();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('reserves')
              .where('owner', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .where("type", isEqualTo: "completed")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              print("==================================compeleted");
              print(snapshot.data!.docs);
              return const Center(child: Text('No reserves found'));
            }
            List<DocumentSnapshot> reserves = snapshot.data!.docs;

            return ListView.builder(
              itemCount: reserves.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Container(
                    margin: const EdgeInsets.only(left: 2, right: 2),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 0.8,
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: background),
                                child: IconButton(
                                    onPressed: () async {
                                      String type = "";
                                      DocumentSnapshot doc =
                                          await FirebaseFirestore
                                              .instance
                                              .collection("handman")
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .get();
                                      if (doc.exists) {
                                        type = "handman";
                                      } else {
                                        type = "users";
                                        //
                                      }
                                      QuerySnapshot qs = await FirebaseFirestore
                                          .instance
                                          .collection("discussions")
                                          .where("receiver",
                                              isEqualTo: reserves[index]
                                                  ["receiver"])
                                          .get();
                                      if (qs.docs.isNotEmpty) {
                                        Get.to(ChatScreen(
                                          id: qs.docs.first.id,
                                          type: type,
                                        ));
                                      } else {
                                        DocumentReference doc =
                                            await FirebaseFirestore.instance
                                                .collection("discussions")
                                                .add({
                                          "owner": FirebaseAuth
                                              .instance.currentUser!.uid,
                                          "receiver": reserves[index]
                                              ["receiver"],
                                          "messages": []
                                        });
                                        print("not exist");
                                        Get.to(ChatScreen(
                                          id: doc.id,
                                          type: type,
                                        ));
                                      }
                                    },
                                    icon: const Icon(
                                      FontAwesomeIcons.commentDots,
                                      color: kcolor1,
                                    )),
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 60,
                                  ),
                                  StreamBuilder<DocumentSnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('handman')
                                          .doc(reserves[index]["receiver"])
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }

                                        if (snapshot.hasError) {
                                          return Center(
                                              child: Text(
                                                  'Error: ${snapshot.error}'));
                                        }

                                        if (!snapshot.hasData ||
                                            !snapshot.data!.exists) {
                                          return const Center(
                                              child: Text(
                                                  'No user information found'));
                                        }

                                        var userData = snapshot.data!.data()
                                            as Map<String, dynamic>;

                                        return Column(
                                          children: [
                                            Text("${userData["work"]}"),
                                            Text('${userData["name"]}'),
                                            CustomButton1Booking(
                                              backgroundColor: Colors.green,
                                              text: "مكتملة",
                                              onPressed: () {},
                                            ),
                                          ],
                                        );
                                      }),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: background,
                                        borderRadius: BorderRadius.circular(8)),
                                    height: 120,
                                    child: FittedBox(
                                      child: Image.asset(
                                        'assets/images/11.png',
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 2,
                            color: kbook,
                          ),
                          if (itemExpandedList[index])
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    StreamBuilder<DocumentSnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection("handman")
                                          .doc(reserves[index]["receiver"])
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasError) {
                                          return const Center(
                                            child: Text('Something went wrong'),
                                          );
                                        }

                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }

                                        if (!snapshot.hasData ||
                                            !snapshot.data!.exists) {
                                          return const Center(
                                            child: Text(
                                                'No data found for this user'),
                                          );
                                        }

                                        Map<String, dynamic> data =
                                            snapshot.data!.data()
                                                as Map<String, dynamic>;

                                        // Assuming 'completedTasks' is a list of completed task IDs or similar
                                        int completedTasksCount =
                                            data['completedTasks']?.length ?? 0;

                                        return Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const Text("العنوان"),
                                                Text(data["adresse"])
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const Text("السعر"),
                                                Text(data["price"])
                                              ],
                                            )
                                          ],
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Divider(
                                      thickness: 2,
                                      color: kbook,
                                    ),
                                    CustomButton1Booking(
                                      backgroundColor: Colors.blue,
                                      text: "قيم الخدمة",
                                      onPressed: () {
                                        Get.to(Rate(
                                          doc: reserves[index],
                                        ));
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          GestureDetector(
                            onTap: () => Visability(index),
                            child: customVisibleContainer(isVisible: isVisible),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
