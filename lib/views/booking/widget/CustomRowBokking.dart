import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../chat/chat_screen.dart';

import '../../../core/constent.dart';
import 'button1.dart';

// ignore: must_be_immutable
class CustomRowBokking extends StatelessWidget {
  CustomRowBokking(
      {super.key, this.backgroundColor, this.text, this.width, this.id});
  Color? backgroundColor;
  String? text;
  double? width;
  String? id;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: background),
          child: IconButton(
              onPressed: () async {

                // Navigator.pop(context);
                String type="";
                DocumentSnapshot doc = await FirebaseFirestore.instance
                    .collection("handman")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .get();
                if (doc.exists) {
                  type="handman";
                } else {
                  type="users";
                  //
                }
                QuerySnapshot qs = await FirebaseFirestore
                    .instance
                    .collection("discussions")
                    .where("receiver", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .where("owner",isEqualTo: id)
                    .get();
                if (qs.docs.isNotEmpty) {
                  Get.to(ChatScreen(id: qs.docs.first.id,type: type ,));
                } else {
                  DocumentReference doc = await FirebaseFirestore
                      .instance
                      .collection("discussions")
                      .add({
                    "owner":
                    id,
                    "receiver": FirebaseAuth.instance.currentUser!.uid,
                    "messages": []
                  });
                  print("not exist");
                  Get.to(ChatScreen(id: doc.id,type: type,));
                }
              },
              icon: const Icon(
                FontAwesomeIcons.commentDots,
                color: kcolor1,
              )),
        ),
        Row(
          children: [
            SizedBox(
              width: width,
            ),
            StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(id)
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

                  var userData = snapshot.data!.data() as Map<String, dynamic>;

                  return Column(
                    children: [
                      Text('${userData["name"]}'),
                      CustomButton1Booking(
                        backgroundColor: backgroundColor,
                        text: text,
                        onPressed: () {
                          print("clicked");
                        },
                      )
                    ],
                  );
                }),
            const SizedBox(
              width: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  color: background, borderRadius: BorderRadius.circular(8)),
              height: 120,
              child: FittedBox(
                child: Image.asset(
                  'assets/images/11.png',
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
