import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../chat_screen.dart';
import 'chat_item.dart';

import '../../../core/constent.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  _ChatListState();

  @override
  void initState() {
    // TODO: implement initState
    print(
        "--------------------------------------------------------------------");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.topRight,
            child: Text(
              'الدردشه',
              style: txtstyle2,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('discussions')
                .where("receiver",
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.size==0) {

                return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('discussions')
                        .where("owner",
                            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapshot) {

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      if (!snapshot.hasData ) {
                        return const Center(child: Text('No discussions found'));
                      }
                      List<DocumentSnapshot> owner2Docs = snapshot.data!.docs;
                      print("JUST OWNER");
                      print(owner2Docs);
                      if(owner2Docs.isEmpty)
                        {
                          return const Center(child: Text("لا يوجد دردشة"),);
                        }
                      return Expanded(
                        child: ListView.builder(
                          itemCount: owner2Docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot doc = owner2Docs[index];
                            return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                          id: owner2Docs[index].id, type: "handman"),
                                    ),
                                  );
                                  //GoRouter.of(context).go(AppRouter.chatBody);
                                },
                                child: ChatItem(doc: owner2Docs[index], type: "handman"));
                          },
                        ),
                      );
                    });
              }



              List<DocumentSnapshot> receiver = snapshot.data!.docs;
              print("RCEIVER");
              print(receiver);
             return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('discussions')
                      .where("owner",
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (!snapshot.hasData) {
                      return const Center(child: Text('No discussions found'));
                    }
                    List<DocumentSnapshot> owner2Docs = snapshot.data!.docs;
                    
                    List<DocumentSnapshot> results=[];
                    results.addAll(receiver);
                    results.addAll(owner2Docs);



                    return Expanded(
                      child: ListView.builder(
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot doc = results[index];
                          return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatScreen(
                                        id: results[index].id, type: "handman"),
                                  ),
                                );
                                //GoRouter.of(context).go(AppRouter.chatBody);
                              },
                              child: ChatItem(doc: results[index], type: "handman"));
                        },
                      ),
                    );
                  });

            },
          ),
        ],
      ),
    );
  }
}
