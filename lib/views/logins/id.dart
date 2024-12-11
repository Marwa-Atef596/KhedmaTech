import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma_tech/core/constent.dart';
import 'package:khedma_tech/views/logins/verfication.dart';
import 'package:khedma_tech/views/logins/widget/show_dialog.dart';
import 'package:khedma_tech/views/widget/customTxtFild.dart';
import 'package:khedma_tech/views/logins/work.dart';
import '../../core/assets.dart';
import 'widget/custom_btn_log.dart';

class IdNum extends StatelessWidget {
  bool? email;
  String? name;
  String? phone;
  String? useremail;
  String? password;


  IdNum(bool email, String name, String phone, String useremail,
      String password,
      {super.key}) {
    this.email = email;
    this.name = name;
    this.phone = phone;
    this.useremail = useremail;
    this.password = password;

  }
  final TextEditingController _nationalIdController = TextEditingController();
  Future<bool> Verify_existance_uid(String uid) async {
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection("users")
        .where("national_id", isEqualTo: uid)
        .get();
    if (qs.docs.isNotEmpty) {
      return true;
    }
    QuerySnapshot qs2 = await FirebaseFirestore.instance
        .collection("handman")
        .where("national_id", isEqualTo: uid)
        .get();
    if (qs2.docs.isNotEmpty) {
      return true;
    }
    return false;
  }

  void Verify_user() {}

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image(
                        image: AssetImage(AssetsData.icon),
                        height: 60,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'من فضلك ادخل رقمك القومي',
                    style: txtstyle2,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  CustomTxtFild(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'من فضلك أدخل رقم القومي';
                      }
                      if (value.length != 14) {
                        return 'من فضلك أدخل رقم قومي مكون من 14 أرقام';
                      }
                      return null;
                    },
                    controller: _nationalIdController,
                    keyboardType: TextInputType.number,
                    txt: ' الرقم القومي',
                  ),
                  const SizedBox(
                    height: 350,
                  ),
                  CustomBtnLog(
                      title: 'التالى',
                      backgroundColor: kcolor1,
                      onPressed: () async {
                        Handle_national_id(_nationalIdController.text, context);


                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> Handle_national_id(String nid, BuildContext c) async {
    if (_nationalIdController.text.length != 14) {
     Get.snackbar("Error", "الرجاء ادخال رقم قومي مكون من 14 رقم");
    } else {
      if (await Verify_existance_uid(_nationalIdController.text) == true) {

        Get.snackbar("Error", "رقم قومي تابع لمستخدم اخر");
      } else {
        Get.off(works(
            email!,
            name!,
            phone!,
            this.useremail!,
            password!,
            _nationalIdController.text.trim()));

            /*
          if (email == true) {
            showDialog(
                context: c,
                builder: (context) {
                  return AlertDialog(
                    title: Text("جار تسجيل حسابك"),
                    content: Container(
                      height: 20,
                      width: 20,
                      child: Center(
                        child: Container(
                          child: CircularProgressIndicator(),
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  );
                });
            await Future.delayed(Duration(seconds: 3), () async {

              UserCredential uc = await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: this.useremail!, password: this.password!);
              InsertData(name,phone,useremail,password,_nationalIdController.text,uc.user!.uid);
              showDialog(
                  context: c,
                  builder: (context) {
                    return ShowDialogg(
                      image: AssetsData.imgawe,
                      txt: 'تم انشاء حسابك بنجاح',
                      txt2: 'العوده لتسجيل الدخول ',
                    );
                  });

            });
          } else {
            showDialog(
                context: c,
                builder: (context) {
                  return AlertDialog(
                    title: Text("جار إرسال كود التفعيل"),
                    content: Container(
                      height: 20,
                      width: 20,
                      child: Center(
                        child: Container(
                          child: CircularProgressIndicator(),
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  );
                });
            await Future.delayed(Duration(seconds: 3), () async {
              await FirebaseAuth.instance.verifyPhoneNumber(
                phoneNumber: "+20" + phone!,
                timeout: const Duration(seconds: 60),
                verificationCompleted:
                    (PhoneAuthCredential phoneAuthCredential) {
                  // Auto-resolving SMS code (this could happen when the phone number
                  // is already verified on this device)
                  print("Verification completed automatically");

                  // Optionally, you can sign in the user directly if you want
                  // await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
                },
                verificationFailed: (FirebaseAuthException authException) {
                  // Handle error when verification fails
                  showDialog(
                      context: c,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Error"),
                          content: Text("${authException.message}"),
                        );
                      });

                  // Optionally, show an error message to the user
                },
                codeSent: (String verificationId, int? forceResendingToken) {
                  // Handle when the code is sent

                  Get.off(
                      Verfiy(
                    phone: "+20" + phone!,
                    national_id: _nationalIdController.text,
                    name: this.name,
                    password: this.password,
                    verification_id: verificationId,
                    work: null,


                  ));

                  // Store the verificationId for later use to verify the code
                  // You can also use forceResendingToken to resend the code if needed
                },
                codeAutoRetrievalTimeout: (String verificationId) {
                  // Handle when the code auto retrieval times out
                  print("Code auto-retrieval timeout");
                  // Optionally, notify the user to enter the code manually
                },
              );
            });
          }

        */


      }
    }
  }

  void InsertData(String? name, String? phone, String? useremail, String? password, String nid,String id) {
    print("@@@@@@@@@@@@@@@@@@@@@@@@");
    print(name);
    FirebaseFirestore.instance.collection("users").doc(id).set({
      "name":name,
      "phone":"+20"+phone!,
      "email":useremail,
      "password":password,
      "national_id":nid,
      "favorites":[],



    });
  }
}
