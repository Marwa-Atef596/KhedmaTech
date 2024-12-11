import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khedma_tech/views/logins/widget/show_dialog.dart';

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
        this.name,
        this.phone,
        this.useremail,
        this.password,
        this.national_id,
        this.work,
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
  ) {}
  List Suggestions=[];
  TextEditingController price=new TextEditingController();
  TextEditingController adresse=new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false,body: Column(
      children: [
        Container(child: Text("السعر"),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*30/100),),

        Container(
          height: MediaQuery.of(context).size.height * 10 / 100,
          child: TextFormField(controller: price,),
          width: MediaQuery.of(context).size.width * 90 / 100,
        ),
        Text("العنوان"),
        Container(
          height: MediaQuery.of(context).size.height * 10 / 100,
          child: TextFormField(
            onChanged: (value) {
              setState(() {

              });
            },
            controller: adresse,
          ),
          width: MediaQuery.of(context).size.width * 90 / 100,
        ),


        CustomBtnLog(
          title: 'انشاء حساب',
          backgroundColor: kcolor1,
          onPressed: () async {



           if(this.useremail!=null)  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: this.useremail!, password: this.password!);
            await FirebaseFirestore.instance
                .collection('handman')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .set({
              'name': this.name,
              'email': this.useremail!=null?this.useremail:"",
              'password': this.password,
              "phone": this.phone,
              'national_id': this.national_id,
              'work': this.work,
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
