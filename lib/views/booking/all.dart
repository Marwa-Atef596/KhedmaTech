import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khedma_tech/views/booking/widget/custombotombokking.dart';

import '../../core/constent.dart';
import 'widget/CustomRowBokking.dart';
import 'widget/Customtextrow2.dart';
import 'widget/customVisibleContainer.dart';

class allBooking extends StatefulWidget {
  const allBooking({super.key});

  @override
  _allBookingState createState() => _allBookingState();
}

class _allBookingState extends State<allBooking> {
  bool isVisible = false;

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
      type = "users";
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    set_type();
    print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<type==${type}");
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('reserves')
              .where(type == "users" ? 'owner' : 'receiver',
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
                      child: StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("users")
                            .doc(reserves[index]["owner"])
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

                          if (!snapshot.hasData || !snapshot.data!.exists) {
                            return Center(
                              child: Text('No data found for this user'),
                            );
                          }

                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;
                        print(data);
                          return Column(
                            children: [
                              CustomRowBokking(
                                  text: reserves[index]["type"],
                                  backgroundColor: const Color(0xff40A2D8),
                                  width: 60,
                                  id: reserves[index]["owner"]),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [

                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [

                                            Text("العنوان"),
                                            Text(data["adresse"])
                                          ],
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
                                child: customVisibleContainer(
                                    isVisible: isVisible),
                              ),
                            ],
                          );
                        },
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
