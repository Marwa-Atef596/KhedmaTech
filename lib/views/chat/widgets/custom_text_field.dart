import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
   CustomTextField({super.key, this. doc});
  DocumentSnapshot? doc;
  TextEditingController tex=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 24.0,
          right: 24.0,
          bottom: 24.0
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                  controller: tex,
                  decoration: InputDecoration(
                    hintText: 'اكتب رسالتك',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xff0B60B0)
                      )
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xff0B60B0)
                      )
                    ),
                    suffixIcon: const Icon(
                      Icons.mic,
                      color: Colors.blueAccent,
                      size: 30,
                    )
                  ),
                ),
              ),
            ),
            const SizedBox(width: 6,),
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blueAccent,
              child: IconButton(
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                onPressed: ()async{
              DocumentSnapshot document=await    FirebaseFirestore.instance.collection("discussions").doc(doc!.id).get();
              List Messages=document["messages"];
              Messages.add({
                "content":tex.text,
                "owner":FirebaseAuth.instance.currentUser!.uid
              });
                  FirebaseFirestore.instance.collection("discussions").doc(doc!.id).update(
                      {
                        "messages":Messages

                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
