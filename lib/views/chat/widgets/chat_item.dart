import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khedma_tech/core/assets.dart';
import 'package:khedma_tech/core/reusable/text_style_helper.dart';

class ChatItem extends StatelessWidget {
  ChatItem({super.key, this.doc, this.type}) {
    print("////////////////////////////////////////////");
    print(this.doc!["owner"]);
    print(this.type);
  }
  DocumentSnapshot? doc;
  String? type;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 80 / 100,
      height: MediaQuery.of(context).size.height * 10 / 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue[900],
            child: Text(
              "${this.doc!["messages"].length}",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(right: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection(
                              this.type == "users" ? "handman" : "users")
                          .doc(this.type == "users"
                              ? this.doc!["receiver"]
                              : this.doc!["owner"])
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("");
                        }
                        if (snapshot.hasError) {
                          return Text("Error");
                        }
                        if (snapshot.hasData == false ||
                            !snapshot.data!.exists) {
                          return StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("handman")
                                  .doc(this.doc!["receiver"])
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }

                                if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}'));
                                }

                                if (!snapshot.hasData ||
                                    !snapshot.data!.exists) {
                                  return Center(
                                      child: Text('No user information found'));
                                }
                                var userData = snapshot.data!.data()
                                    as Map<String, dynamic>;

                                return Text("${userData["name"]}",style: TextStyle(fontWeight: FontWeight.bold),);
                              });
                          return Text("NOT EXISTING");
                        }
                        return Text(
                          "${snapshot.data!["name"]}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        );
                      },
                    ),
                    this.doc!["messages"].length == 0
                        ? Text("لا يوجد رسايل")
                        : Text(this.doc!["messages"]
                            [this.doc!["messages"].length - 1]["content"])
                  ],
                ),
              ),
              CircleAvatar(
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
