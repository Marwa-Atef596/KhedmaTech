import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../logins/login.dart';

import '../../../core/constent.dart';
import '../../Rate & Review/widget/customdialograte.dart';
import '../../logins/widget/custom_btn_log.dart';

// ignore: must_be_immutable
class BotomBokking extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _deleteAccount(BuildContext c) async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        String uid = user.uid;
        await user.delete();
        // Handle successful account deletion, e.g., navigate to a different page
        FirebaseFirestore.instance.collection(type!).doc(uid).delete();
        print('User account deleted');
        showDialog(
            context: c,
            builder: (context) {
              return DialogRate(
                txt: 'User account deleted',
              );
            });
        Navigator.pushReplacement(
          c,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        print("--------------------");
        if (e.code == 'requires-recent-login') {
          // Re-authenticate the user and then try to delete again

          if (data!.containsKey("email")) {
            AuthCredential credential = EmailAuthProvider.credential(
              email: data!["email"],
              password:
                  data!["password"], // Replace with the user's actual password
            );
            await user.reauthenticateWithCredential(credential);
            String uid = user.uid;
            await user.delete();
            // Handle successful account deletion, e.g., navigate to a different page
            FirebaseFirestore.instance.collection(type!).doc(uid).delete();
            print('User account deleted');
            showDialog(
                context: c,
                builder: (context) {
                  return DialogRate(
                    txt: 'User account deleted',
                  );
                });
            Navigator.pushReplacement(
              c,
              MaterialPageRoute(
                builder: (context) => const Login(),
              ),
            );
          } else {
            await _auth.verifyPhoneNumber(
              phoneNumber: data!["phone"],
              verificationCompleted: (PhoneAuthCredential credential) async {
                // Auto-retrieval or instant verification
              },
              verificationFailed: (FirebaseAuthException e) {
                print('Phone number verification failed: ${e.message}');
                
              },
              codeSent: (String verificationId, int? resendToken) {
                Navigator.of(c).pop();
                Get.defaultDialog(
                    title: "We have sent otp code to your phone",
                    content: Column(
                      children: [
                        TextFormField(),
                        InkWell(
                          child: const Text("Delete"),
                          onTap: () {},
                        )
                      ],
                    ));
              },
              codeAutoRetrievalTimeout: (String verificationId) {},
            );
          }
        } else {
          print('');
          showDialog(
              context: c,
              builder: (context) {
                return DialogRate(
                  txt: 'Failed to delete user: $e',
                );
              });
        }
      }
    } else {
      print('No user is signed in.');
    }
  }

  BotomBokking(
      {super.key,
      this.txt1,
      this.txt2,
      this.txt3,
      this.txt4,
      this.type,
      this.data, this.id});
  String? type;
  String? txt1;
  String? txt2;
  String? txt3;
  String? txt4;
  String? id;
  Map<String, dynamic>? data;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            child: Text(
              txt1!,
              style: txtstyle222,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              color: kbook,
              thickness: 2,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            txt2!,
            style: txtstyle6,
          ),
          const SizedBox(
            height: 50,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              color: kbook,
              thickness: 2,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 180,
                  child: CustomBtnLog(
                    backgroundColor: kcolor1,
                    title: txt3,
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Get.off(const Login());
                    },
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: CustomBtnLog(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: kcolor1),
                    Txtcolor: Colors.black,
                    title: txt4,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
