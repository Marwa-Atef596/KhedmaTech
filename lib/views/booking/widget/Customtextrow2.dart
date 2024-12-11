import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Customtextrow2 extends StatelessWidget {
  Customtextrow2({
    super.key,
    this.txt1,
    this.txt2, this. id,
  });
  String? txt1;
  String? txt2;
  String? id;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          txt1!,
          style: const TextStyle(fontSize: 18.0),
        ),
        const SizedBox(
          width: 20,
        ),
        StreamBuilder<DocumentSnapshot>(
    stream: FirebaseFirestore.instance.collection('handman').doc(this.id).snapshots(),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(child: CircularProgressIndicator());
    }

    if (snapshot.hasError) {
    return Center(child: Text('Error: ${snapshot.error}'));
    }

    if (!snapshot.hasData || !snapshot.data!.exists) {
    return Center(child: Text('No user information found'));
    }
    var userData = snapshot.data!.data() as Map<String, dynamic>;
    return Text(txt1=='سعر المعاينة'?userData["adress"]:userData["price"]);}
    ),
      ],
    );
  }
}
