import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'show_dialog.dart';

import '../../../core/assets.dart';
import '../../../core/constent.dart';
import 'custom_btn_log.dart';

class check_adress extends StatefulWidget {
  String? name;
  String? phone;
  String? useremail;
  String? password;
  String? national_id;
  String? work;
  check_adress(this.name, this.phone, this.useremail, this.password,
      this.national_id, this.work,
      {super.key});

  @override
  State<check_adress> createState() => _check_adressState(
        name,
        phone,
        useremail,
        password,
        national_id,
        work,
      );
}

class _check_adressState extends State<check_adress> {
  String? name;
  String? phone;
  String? useremail;
  String? password;
  String? national_id;
  String? work;
  _check_adressState(
    this.name,
    this.phone,
    this.useremail,
    this.password,
    this.national_id,
    this.work,
  );
  List Suggestions=[];
  TextEditingController price=TextEditingController();
  TextEditingController adresse=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false,body: Column(
      children: [
        Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*30/100),child: const Text("السعر"),),

        SizedBox(
          height: MediaQuery.of(context).size.height * 10 / 100,
          width: MediaQuery.of(context).size.width * 90 / 100,
          child: TextFormField(controller: price,),
        ),
        const Text("العنوان"),
        SizedBox(
          height: MediaQuery.of(context).size.height * 10 / 100,
          width: MediaQuery.of(context).size.width * 90 / 100,
          child: TextFormField(
            onChanged: (value) {
              setState(() {

              });
            },
            controller: adresse,
          ),
        ),


        CustomBtnLog(
          title: 'انشاء حساب',
          backgroundColor: kcolor1,
          onPressed: () async {



           if(useremail!=null) {
             await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: useremail!, password: password!);
           }
            await FirebaseFirestore.instance
                .collection('handman')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .set({
              'name': name,
              'email': useremail ?? "",
              'password': password,
              "phone": phone,
              'national_id': national_id,
              'work': work,
              "price":price.text,
              "adresse":adresse.text,
              "ranks":[],
              "favorties":[]

            }).then((_) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ShowDialogg(
                    image: AssetsData.imgawe,
                    txt: 'تم انشاء حسابك بنجاح',
                    txt2: 'العوده لتسجيل الدخول ',
                  );
                },
              );
            }).catchError((error) {
              print('Error adding document: $error');
            });
          },
        )
      ],
    ),);
  }
}
