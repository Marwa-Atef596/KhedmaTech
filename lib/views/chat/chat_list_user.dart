import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'widgets/chat_item.dart';

import '../../../core/constent.dart';

class ChatListUser extends StatefulWidget {
  const ChatListUser({super.key});


  @override
  State<ChatListUser> createState() => ChatListUserState();
}

class ChatListUserState extends State<ChatListUser> {
  ChatListUserState();


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
                .where( "owner" ,
                isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                 return const Center(child: Text('No discussions found'));
              }

              List<DocumentSnapshot> owner2Docs = snapshot.data!.docs;

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
                                  id: owner2Docs[index].id, type: "users"),
                            ),
                          );
                          //GoRouter.of(context).go(AppRouter.chatBody);
                        },
                        child: ChatItem(doc: owner2Docs[index], type: "users"));
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
