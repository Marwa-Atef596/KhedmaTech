import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'chat_list_user.dart';
import 'widgets/chat_list.dart';

class ChatListView extends StatelessWidget {
  ChatListView({super.key});
  String type = "";

  Future<DocumentSnapshot> setType() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("handman")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (doc.exists) {
      type = "handman";
    } else {
      type = "users";
    }
    print(type);
    print("---------------------");
    print(FirebaseAuth.instance.currentUser!.uid);
    return doc;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<DocumentSnapshot>(
          future: setType(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }  if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            print("**************************");
            print(snapshot.data);
            if(snapshot.hasData==false  )
              {
                return const Text("NO DATA");

              }


            print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<$type");
            return  type=="users"?  const ChatListUser():  const ChatList();



          },
        ),
      ),
    );
  }
}
