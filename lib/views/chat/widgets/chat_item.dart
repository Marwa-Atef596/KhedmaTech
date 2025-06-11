import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  ChatItem({super.key, this.doc, this.type}) {
    print("////////////////////////////////////////////");
    print(doc!["owner"]);
    print(type);
  }
  DocumentSnapshot? doc;
  String? type;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 80 / 100,
      height: MediaQuery.of(context).size.height * 10 / 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue[900],
            child: Text(
              "${doc!["messages"].length}",
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection(
                              type == "users" ? "handman" : "users")
                          .doc(type == "users"
                              ? doc!["receiver"]
                              : doc!["owner"])
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text("");
                        }
                        if (snapshot.hasError) {
                          return const Text("Error");
                        }
                        if (snapshot.hasData == false ||
                            !snapshot.data!.exists) {
                          return StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("handman")
                                  .doc(doc!["receiver"])
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }

                                if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}'));
                                }

                                if (!snapshot.hasData ||
                                    !snapshot.data!.exists) {
                                  return const Center(
                                      child: Text('No user information found'));
                                }
                                var userData = snapshot.data!.data()
                                    as Map<String, dynamic>;

                                return Text("${userData["name"]}",style: const TextStyle(fontWeight: FontWeight.bold),);
                              });
                          return const Text("NOT EXISTING");
                        }
                        return Text(
                          "${snapshot.data!["name"]}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        );
                      },
                    ),
                    doc!["messages"].length == 0
                        ? const Text("لا يوجد رسايل")
                        : Text(doc!["messages"]
                            [doc!["messages"].length - 1]["content"])
                  ],
                ),
              ),
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/11.png'),
                radius: 30,
              )
            ],
          )
        ],
      ),
    );
  }
}
