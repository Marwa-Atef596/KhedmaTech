import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/constent.dart';

// ignore: must_be_immutable
class CustomController extends StatelessWidget {
  CustomController({super.key, this.onTap, this.txt});
  void Function()? onTap;
  String? txt;
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
  Widget build(BuildContext context) {
    set_type();
    return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 170,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: kcolor1)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: !txt!.contains("كل")
                        ? FirebaseFirestore.instance
                            .collection("reserves")
                            .where("receiver",
                                isEqualTo:
                                    FirebaseAuth.instance.currentUser!.uid)
                            .where("type",
                                isEqualTo: txt!.contains("المكتملة")
                                    ? "completed"
                                    : txt!.contains("القادمة")
                                        ? "forward"
                                        : txt!.contains("الملغية")
                                            ? "canceled"
                                            : "")
                            .snapshots()
                        : FirebaseFirestore.instance
                            .collection("reserves")
                            .where("receiver",
                                isEqualTo:
                                    FirebaseAuth.instance.currentUser!.uid)
                            .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('Something went wrong'),
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (!snapshot.hasData || snapshot.data!.size == 0) {
                        return const Center(
                          child: Text('0'),
                        );
                      }

                      return Text("${snapshot.data!.docs.length}");
                    },
                  ),
                  Text(txt!)
                ],
              ),
            ]),
          ),
        ));
  }
}
