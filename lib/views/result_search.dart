import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Rate%20&%20Review/Rate%20&%20Review.dart';

import '../../core/constent.dart';

class result_search extends StatelessWidget {
  String? data;
  result_search(
      this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(children: [IconButton(
                onPressed: () async {
                  FirebaseFirestore.instance.collection("reserves").doc().set({
                    "owner":FirebaseAuth.instance.currentUser!.uid,
                    "receiver":data,
                    "type":"forward"

                  });
                  Get.snackbar("Notification","تم الحجز",backgroundColor: Colors.blue);

                },
                icon: const Icon(
                  Icons.receipt,
                  color: kcolor1,
                )),IconButton(onPressed: (){
              FirebaseFirestore.instance.collection("discussions").doc().set({
                "owner1":FirebaseAuth.instance.currentUser!.uid,
                "owner2":data,
                "messages":[]

              });
              Get.snackbar("Notification","تم اجراء المحادثة");


            }, icon: const Icon(
              Icons.chat,
              color: kcolor1,
            ))],),

            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(stream: FirebaseFirestore.instance.collection("handman").doc(data).snapshots(), builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(),);
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || !snapshot.data!.exists) {
                return const Text('Document does not exist');
              }
              else
              {
                return  Column(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '${snapshot.data!.data()!["work"]}',
                      style: txtstyle111,
                    ),
                    Text("${snapshot.data!.data()!["name"]}"),
                    Text("ج م ${snapshot.data!.data()!["price"]} للمعاينة "),
                    const customtxtrate()
                  ],
                );
              }
            },),
            Container(
              decoration: BoxDecoration(
                  color: background, borderRadius: BorderRadius.circular(8)),
              width: 120,
              height: 120,
              child: Image.asset(
                'assets/images/11.png',
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class customtxtrate extends StatelessWidget {
  const customtxtrate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('٣٢  تقييم'),
        const SizedBox(
          width: 5,
        ),
        const Text('|'),
        const SizedBox(
          width: 5,
        ),
        Row(
          children: [
            const Text('٤.٥'),
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  Rate(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.star,
                  color: krate,
                )),
          ],
        )
      ],
    );
  }
}

