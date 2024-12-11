import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khedma_tech/core/constent.dart';
import 'package:khedma_tech/views/logins/widget/custom_btn_log.dart';
import '../widget/customAppService.dart';
import 'widget/customdialograte.dart';
import 'widget/customratingRewie.dart';
import 'widget/customtxtarea.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';

class Rate extends StatefulWidget {
   Rate({this.doc,super.key});
DocumentSnapshot? doc;
  @override
  State<Rate> createState() => _RateState(doc: doc);
}

class _RateState extends State<Rate> {
  _RateState( {this.doc});
  DocumentSnapshot? doc;
  TextEditingController comment=new TextEditingController();
  double rating=3;
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
                    txxt: 'تقييم الخدمة',
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff40A2D8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () {
                    print("@-----------");
                    print(rating);
                    // Button pressed logic here
                  },
                  child: const Text(
                    'قيم الخدمة',
                    style: txtstyle1,
                  ),
                ),
                Container(width: MediaQuery.of(context).size.width*90/100,height: 40,
                    child: Center(child: RatingBar(
                      alignment: Alignment.center,
                      filledIcon: Icons.star,
                      emptyIcon: Icons.star_border,
                      onRatingChanged: (value) {

                        setState(() {
                          rating=value ;
                        });



                      },
                      initialRating: 3,
                      maxRating: 5,
                    ),)
                ),
                const SizedBox(
                  height: 100,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "اكتب تعليقك"!,
                          style: txtstyle1,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: comment,
                      textAlign: TextAlign.right,
                      minLines: 6,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: kcolor1, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: kcolor1, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        // labelText: 'Enter text',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomBtnLog(
                  title: 'ارسال',
                  onPressed: () async {

                    DocumentSnapshot doc=await   FirebaseFirestore.instance.collection("handman").doc(this.doc!["receiver"]).get();
                    List ranks=doc.get("ranks");

                    ranks.add({
                      "owner":FirebaseAuth.instance.currentUser!.uid,
                      "value":rating,
                      "comment":comment.text,
                      "work":this.doc!.id
                    });
                    FirebaseFirestore.instance.collection("handman").doc(this.doc!["receiver"]).update({
                      "ranks":ranks
                    });

                    showDialog(
                        context: context,
                        builder: (context) {
                          return DialogRate(
                            txt: 'شكرا على تقييمك',
                          );
                        });
                  },
                  backgroundColor: kcolor1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


