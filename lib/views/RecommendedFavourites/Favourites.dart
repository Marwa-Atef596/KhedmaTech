import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widget/customAppService.dart';
import '../widget/custom_handman.dart';

class Favourites extends StatefulWidget {
   const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: customAppService(
                  txxt: 'الحرفيين المفضليين',
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                  child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || !snapshot.data!.exists) {
                    return StreamBuilder<
                            DocumentSnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection("handman")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData ||
                              !snapshot.data!.exists) {
                            return const Text('لا يوجد حرفيين مفضلين');
                          }
                          List<dynamic> Friends = snapshot.data!.data()!["favorites"];
                          if (Friends.isNotEmpty) {
                            return Container(
                              child: ListView.builder(
                                itemCount: Friends.length,
                                itemBuilder: (context, index) {
                                  return StreamBuilder<
                                      DocumentSnapshot<Map<String, dynamic>>>(
                                    stream: FirebaseFirestore.instance
                                        .collection("handman")
                                        .doc(Friends[index])
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else if (!snapshot.hasData ||
                                          !snapshot.data!.exists) {
                                        return const Text('لا يوجد حرفيين مفضلين');
                                      } else {
                                        print("hello");
                                        return HandMan(
                                          snapshot.data!.id,
                                        );
                                      }
                                    },
                                  );
                                },
                              ),
                            );
                          } else {
                            return const Center(
                              child: Text("! لا يوجد حرفيين مفضلين "),
                            );
                          }
                        });
                  } else {
                    List<dynamic> Friends = snapshot.data!.data()!["favorites"];
                    if (Friends.isNotEmpty) {
                      return Container(
                        child: ListView.builder(
                          itemCount: Friends.length,
                          itemBuilder: (context, index) {
                            return StreamBuilder<
                                DocumentSnapshot<Map<String, dynamic>>>(
                              stream: FirebaseFirestore.instance
                                  .collection("handman")
                                  .doc(Friends[index])
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else if (!snapshot.hasData ||
                                    !snapshot.data!.exists) {
                                  return const Text('لا يوجد حرفيين مفضلين');
                                } else {
                                  print("hello");
                                  return HandMan(
                                    snapshot.data!.id,
                                  );
                                }
                              },
                            );
                          },
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text("! لا يوجد حرفيين مفضلين "),
                      );
                    }
                  }
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
