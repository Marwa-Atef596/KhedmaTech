import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khedma_tech/views/booking/widget/custombotombokking.dart';

import '../../core/constent.dart';
import '../booking/widget/CustomRowBokking.dart';
import '../booking/widget/customVisibleContainer.dart';



class handman_Booking_forward extends StatefulWidget {
  handman_Booking_forward({super.key});

  @override
  handman_Booking_forwardState createState() => handman_Booking_forwardState();
}

class handman_Booking_forwardState extends State<handman_Booking_forward> with AutomaticKeepAliveClientMixin {
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





  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("reserves")
                .where("receiver",isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .where("type",isEqualTo: "forward")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
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
                            CustomRowBokking(
                                text: 'قادمة',
                                backgroundColor: const Color(0xff40A2D8),
                                width: 60,
                                id: completed[index]["owner"]),
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
                                            .collection("users")
                                            .doc(completed[index]["owner"])
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasError) {
                                            return Center(
                                              child: Text('Something went wrong'),
                                            );
                                          }

                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return Center(
                                              child: CircularProgressIndicator(),
                                            );
                                          }

                                          if (!snapshot.hasData || !snapshot.data!.exists) {
                                            return Center(
                                              child: Text('No data found for this user'),
                                            );
                                          }

                                          Map<String, dynamic> data =
                                          snapshot.data!.data() as Map<String, dynamic>;

                                          // Assuming 'completedTasks' is a list of completed task IDs or similar
                                          int completedTasksCount = data['completedTasks']?.length ?? 0;

                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [Text("العنوان"), Text(data["adresse"])],
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
