import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'booking/widget/button1.dart';

import 'chat/chat_screen.dart';

class details_handman extends StatelessWidget {
  details_handman(this.data, this.type, {super.key});
  String? type;
  String? data;
  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser!.uid);
    print("OK OK OK OK OK ");
    return Scaffold(
      body: Expanded(
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("handman")
              .doc(data)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Text("Error");
            }
            if (snapshot.hasData == false || snapshot.data!.exists == false) {
              return const Center(
                child: Text("NO user"),
              );
            }
            num moy = 0;
            for (int i = 0; i < snapshot.data!["ranks"].length; i++) {
              moy = moy + snapshot.data!["ranks"][i]["value"];
            }
            if (snapshot.data!["ranks"].length == 0) {
              moy = 0;
            } else {
              moy = moy / snapshot.data!["ranks"].length;
            }
            print("**********");
            print(moy);

            return ListView(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 5 / 100),
                  height: MediaQuery.of(context).size.height * 40 / 100,
                  color: Colors.red,
                  child: Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 40 / 100,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8)),
                        child: Image.asset(
                          'assets/images/11.png',
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.red,
                            size: 30,
                          ))
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 90 / 100,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 2 / 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () async {
                            print(type);
                            print("------------------------------------------------");
                            print(FirebaseAuth.instance.currentUser!.uid);
                            DocumentSnapshot dc = await FirebaseFirestore
                                .instance
                                .collection(type=="users"?"users":"handman")
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .get();
                            List fav = dc["favorites"];
                            if (fav.contains(data)) {
                              fav.remove(data);
                            } else {
                              fav.add(data);
                            }
                            FirebaseFirestore.instance
                                .collection(type=="users"?"users":"handman")
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .update({"favorites": fav});
                            if (fav.contains(data)) {
                              Get.snackbar("Notification", "تمت الاضافة ",
                                  backgroundColor: Colors.green);
                            } else {
                              Get.snackbar("Notification", "تمت الازالة",
                                  backgroundColor: Colors.green);
                            }
                          },
                          icon: StreamBuilder<DocumentSnapshot>(
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Text("");
                              }
                              List fav = snapshot.data!["favorites"];
                              if (fav.contains(data)) {
                                return const Icon(
                                  CupertinoIcons.heart_fill,
                                  color: Colors.red,
                                );
                              }
                              return const Icon(
                                CupertinoIcons.heart,
                                color: Colors.lightBlue,
                              );
                            },
                            stream: FirebaseFirestore.instance
                                .collection(type=="users"?"users":"handman")
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .snapshots(),
                          )),
                      Text(
                        "${snapshot.data!["work"]}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlue,
                            fontSize: 20),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 90 / 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(""),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: Text(
                                  " ${snapshot.data!["ranks"].length} تقييم",
                                  textDirection: TextDirection.rtl),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: const Text(
                                "|",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: Row(
                                children: [
                                  Text("$moy"),
                                  const Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Text(
                                "${snapshot.data!["name"]}",
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 90 / 100,
                  margin: const EdgeInsets.only(top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(""),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 20),
                            child: Text(
                              "${snapshot.data!["adresse"]}",
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Icon(
                            Icons.location_on,
                            size: 50,
                            color: Colors.blue,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 90 / 100,
                  margin: const EdgeInsets.only(top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(""),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 20),
                            child: Text("${snapshot.data!["phone"]}",
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          const Icon(
                            Icons.phone_enabled,
                            size: 40,
                            color: Colors.blue,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 90 / 100,
                  margin: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(""),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 20),
                            child: Text(
                              "${snapshot.data!["price"]} ج م للمعاينة",
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 90 / 100,
                  margin: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 1),
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back),
                              onPressed: () {},
                            ),
                          ),
                          const Text("عرض الكل")
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 20),
                            child: const Text(
                              "التقييم و المراجعات",
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                if (snapshot.data!["ranks"].length == 0)
                  const Center(
                    child: Text("No Reviews *"),
                  )
                else
                  for (int i = 0; i < snapshot.data!["ranks"].length; i++)
                    Container(
                      margin: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 90 / 100,
                      height: 100,
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 90 / 100,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 2),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.orange,
                                          ),
                                          Text(
                                              " ${snapshot.data!["ranks"][i]["value"]} ")
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(right: 5),
                                            child: StreamBuilder<
                                                    DocumentSnapshot>(
                                                builder: (context, snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return const Text("");
                                                  }
                                                  if (snapshot.hasError) {
                                                    return const Text("error");
                                                  }
                                                  if (snapshot.hasData ==
                                                          false ||
                                                      snapshot.data!.exists ==
                                                          false) {
                                                    return const Text("No User");
                                                  }
                                                  return Text(
                                                    "${snapshot.data!["name"]}",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  );
                                                },
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection("users")
                                                    .doc(snapshot.data!["ranks"]
                                                        [i]["owner"])
                                                    .snapshots()),
                                          ),
                                          Container(
                                            child: const CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  'assets/images/11.png'),
                                              radius: 30,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10, right: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(""),
                                      snapshot.data!["ranks"][i]["comment"] ==
                                              ""
                                          ? const Text("No Comment")
                                          : Text(
                                              "${snapshot.data!["ranks"][i]["comment"]}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              label: "",
              icon: CustomButton1Booking(
                onPressed: () async {
                  QuerySnapshot qs = await FirebaseFirestore.instance
                      .collection("discussions")
                      .where("receiver", isEqualTo: data)
                      .where("owner",isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .get();
                  if (qs.docs.isNotEmpty) {
                    Get.to(ChatScreen(id: qs.docs.first.id,type:type));
                  } else {
                    DocumentReference doc = await FirebaseFirestore.instance
                        .collection("discussions")
                        .add({
                      "owner": FirebaseAuth.instance.currentUser!.uid,
                      "receiver": data,
                      "messages": []
                    });
                    print("not exist");
                    Get.to(ChatScreen(id: doc.id,type: type,));
                  }
                },
                text: "تواصل معي",
                backgroundColor: Colors.white,
              )),
          BottomNavigationBarItem(
              label: "",
              icon: CustomButton1Booking(
                onPressed: () async {
                  QuerySnapshot qs = await FirebaseFirestore.instance
                      .collection("reserves")
                      .where("receiver", isEqualTo: data)
                      .where("owner",
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .where("type", isEqualTo: "forward")
                      .get();
                  if (qs.docs.isNotEmpty) {
                    Get.snackbar("Notification", 'لقد حجزت هذا المستخدم من قبل',
                        backgroundColor: Colors.green);
                  } else {
                    DocumentReference doc = await FirebaseFirestore.instance
                        .collection("reserves")
                        .add({
                      "owner": FirebaseAuth.instance.currentUser!.uid,
                      "receiver": data,
                      "type": "forward"
                    });
                    Get.snackbar("Notification", "تم الحجز بنجاح",
                        backgroundColor: Colors.green);
                  }
                },
                text: "احجز الان",
                backgroundColor: Colors.blue,
              ))
        ],
      ),
    );
  }
}
