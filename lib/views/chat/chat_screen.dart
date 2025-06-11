import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../core/reusable/text_style_helper.dart';
import 'widgets/custom_text_field.dart';
import 'widgets/messages_list.dart';

import '../widget/customAppService.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, this.id, this.type});
  String? type;

  String? id;

  @override
  Widget build(BuildContext context) {
    print("***************------------------------");
    print(id);
    return SafeArea(
        child: Scaffold(
      // appBar: const OurCustomAppBar(
      //   hasLeading: true,
      //   label: 'User Name',
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('discussions')
                .doc(id)
                .snapshots(),
            builder: (context, snapshot1) {
              if (snapshot1.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot1.hasError) {
                return Center(child: Text('Error: ${snapshot1.error}'));
              }

              if (!snapshot1.hasData || !snapshot1.data!.exists) {
                return const Center(child: Text('No user information found'));
              }

              var disc = snapshot1.data!.data() as Map<String, dynamic>;

              return StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection(type == "users" ? "handman" : "users")
                      .doc(type=="users"?disc["receiver"]:disc["owner"])
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (!snapshot.hasData || !snapshot.data!.exists) {
                      return StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("handman")
                          .doc(disc["receiver"])
                          .snapshots(),
                      builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      if (!snapshot.hasData || !snapshot.data!.exists) {
                      return const Center(child: Text('No user information found'));
                      }
                      var userData =
                      snapshot.data!.data() as Map<String, dynamic>;

                      return Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: customAppService(
                              txxt: '${userData["name"]}',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.blue.withOpacity(0.5),
                            ),
                            child: const Text(
                              'Day',
                              style: AppTextStyleHelper.font14w400White,
                            ),
                          ),
                          Expanded(
                            child: MessagesList(messages: disc["messages"]),
                          ),
                          CustomTextField(
                            doc: snapshot1.data,
                          )
                        ],
                      );

                      });
                    }

                    var userData =
                        snapshot.data!.data() as Map<String, dynamic>;

                    return Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: customAppService(
                            txxt: '${userData["name"]}',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.blue.withOpacity(0.5),
                          ),
                          child: const Text(
                            'Day',
                            style: AppTextStyleHelper.font14w400White,
                          ),
                        ),
                        Expanded(
                          child: MessagesList(messages: disc["messages"]),
                        ),
                        CustomTextField(
                          doc: snapshot1.data,
                        )
                      ],
                    );
                  });
            }),
      ),
    ));
  }
}
