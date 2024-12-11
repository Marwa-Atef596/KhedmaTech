import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widget/customAppService.dart';
import '../widget/custom_handman.dart';

class Recommended extends StatelessWidget {
  const Recommended({super.key});

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
                    txxt: 'الحرفيين المرشحيين',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("handman")
                      .snapshots()

                  ,
                  builder: (context, snapshot) {
                    if(snapshot.connectionState==ConnectionState.waiting)
                    {
                      return CircularProgressIndicator();

                    }
                    if(snapshot.hasError)
                    {
                      return Text("Erorr");

                    }
                    if(!snapshot.hasData || snapshot.data!.size==0)
                    {
                      return Text("NO INFO");
                    }
                    if(snapshot.data!.size==1 && snapshot.data!.docs.first.id==FirebaseAuth.instance.currentUser!.uid)
                    {
                      return Text("لا يوجد مرشحين");
                    }
                    List users=[];
                    users=snapshot.data!.docs;
                    users.sort((a, b) {
                      num ranks_a=0;
                      for(int i=0;i<a["ranks"].length;i++)
                      {
                        ranks_a+=a["ranks"][i]["value"];

                      }
                      if(a["ranks"].length!=0)
                        ranks_a=ranks_a/a["ranks"].length;
                      num ranks_b=0;
                      for(int i=0;i<b["ranks"].length;i++)
                      {
                        ranks_b+=b["ranks"][i]["value"];

                      }
                      if(b["ranks"].length!=0)
                        ranks_b=ranks_b/b["ranks"].length;
                      print(ranks_a);
                      print(ranks_b);
                      print(ranks_b.compareTo(ranks_a));
                      print("--------------------");

                      return ranks_b.compareTo(ranks_a);


                    });

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: users.length,
                      itemBuilder: (BuildContext context, int index) {
                        return  Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: users[index].id!=FirebaseAuth.instance.currentUser!.uid? HandMan(users[index].id):Text(""),
                        );
                      },
                    );
                  },),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
