import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khedma_tech/views/handmen/Service-Carpenter.dart';

import '../widget/customAppService.dart';
import '../widget/custom_handman.dart';

class Carpentry extends StatelessWidget {
  const Carpentry({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: customAppService(
                    txxt: 'نجارة',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
    StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
    .collection('handman')
        .where('work', isEqualTo: 'نجاره')
        .snapshots(),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(child: CircularProgressIndicator());
    }

    if (snapshot.hasError) {
    return Center(child: Text('Error: ${snapshot.error}'));
    }


    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
    return Center(child: Text('No najar found'));
    }
    if(snapshot.data!.size==1 && snapshot.data!.docs.first.id==FirebaseAuth.instance.currentUser!.uid)
    {
      return Text("No najar found");
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (BuildContext context, int index) {
        return  Padding(
          padding: EdgeInsets.only(bottom: 16),
          child:snapshot.data!.docs[index].id!=FirebaseAuth.instance.currentUser!.uid? HandMan( snapshot.data!.docs[index].id):Text(""),
        );
      },
    );},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
