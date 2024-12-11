import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:khedma_tech/views/booking/widget/button1.dart';
import 'package:khedma_tech/views/booking/widget/custombotombokking.dart';

import '../../core/constent.dart';
import '../chat/chat_screen.dart';
import 'widget/CustomRowBokking.dart';
import 'widget/Customtextrow2.dart';
import 'widget/customVisibleContainer.dart';

class RefusedBooking extends StatefulWidget {
  const RefusedBooking({super.key});

  @override
  _RefusedBookingState createState() => _RefusedBookingState();
}

class _RefusedBookingState extends State<RefusedBooking> with AutomaticKeepAliveClientMixin{
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
    set_type();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("reserves")
            .where("owner", isEqualTo: FirebaseAuth.instance.currentUser!.uid)

            .where("type", isEqualTo: "canceled")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            print("==================================refused");
            print(snapshot.data!.docs);
            return Center(child: Text('No reserves found'));
          }
          List<DocumentSnapshot> completed = snapshot.data!.docs;

          return ListView.builder(
            itemCount: completed.length,
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
                                    String type="";
                                    DocumentSnapshot doc = await FirebaseFirestore.instance
                                        .collection("handman")
                                        .doc(FirebaseAuth.instance.currentUser!.uid)
                                        .get();
                                    if (doc.exists) {
                                      type="handman";
                                    } else {
                                      type="users";
                                      //
                                    }
                                    QuerySnapshot qs=await FirebaseFirestore.instance.collection("discussions").where("receiver",isEqualTo: completed[index]["receiver"]).get();
                                    if(qs.docs.isNotEmpty)
                                      {
                                        Get.to(ChatScreen(id :qs.docs.first.id,type: type,));
                                      }
                                    else{
                                            DocumentReference doc=await    FirebaseFirestore.instance.collection("discussions").add({
                                                "owner":FirebaseAuth.instance.currentUser!.uid,
                                              "receiver":completed[index]["receiver"],
                                              "messages":[]
                                                });
                                            print("not exist");
                                            Get.to(ChatScreen(id :doc.id,type: type,));
                                    
                                    
                                    }
                                    


                                  },
                                  icon: const Icon(
                                    FontAwesomeIcons.commentDots,
                                    color: kcolor1,
                                  )),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 50,
                                ),
                                StreamBuilder<DocumentSnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('handman')
                                        .doc(completed[index]["receiver"])
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      }

                                      if (snapshot.hasError) {
                                        return Center(
                                            child: Text(
                                                'Error: ${snapshot.error}'));
                                      }

                                      if (!snapshot.hasData ||
                                          !snapshot.data!.exists) {
                                        return Center(
                                            child: Text(
                                                'No user information found'));
                                      }

                                      var userData = snapshot.data!.data()
                                          as Map<String, dynamic>;

                                      return Column(
                                        children: [
                                          Text(
                                            "${userData["work"]}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text('${userData["name"]}'),
                                          CustomButton1Booking(

                                            backgroundColor: Colors.red,
                                            text: "ملغية",
                                            onPressed: () {

                                            },
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
                                        .doc(completed[index]["receiver"])
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return Center(
                                          child: Text('Something went wrong'),
                                        );
                                      }

                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }

                                      if (!snapshot.hasData ||
                                          !snapshot.data!.exists) {
                                        return Center(
                                          child: Text(
                                              'No data found for this user'),
                                        );
                                      }

                                      Map<String, dynamic> data = snapshot.data!
                                          .data() as Map<String, dynamic>;

                                      // Assuming 'completedTasks' is a list of completed task IDs or similar
                                      int completedTasksCount =
                                          data['completedTasks']?.length ?? 0;

                                      return Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text("العنوان"),
                                              Text(data["adresse"])
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text("السعر"),
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
    ));
  }
}
