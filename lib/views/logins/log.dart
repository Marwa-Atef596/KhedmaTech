import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../dashboard/home_handman.dart';
import '../home_page.dart';
import 'sign_handMan.dart';
import 'verfication.dart';
import '../../core/constent.dart';
import '../widget/customTxtFild.dart';
import 'create_pass.dart';
import 'widget/custom_btn_log.dart';
import '../widget/custom_contianer.dart';
import '../widget/custom_txt_logs.dart';

class Log extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Log({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 200, child: CustomContainer()),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 30,
                ),
                child: Column(
                  children: [
                    Container(
                      child: CustomTxtLogs(
                        txt: 'اهلا بيك من تاني',
                        title: 'تسجيل الدخول لحسابك',
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTxtFild(
                      controller: _emailController,
                      validator: (value) {
                        final emailRegex = RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

                        if (value!.isEmpty || value.isEmpty) {
                          return 'الرجاء ادخال ايمايل او رقم هاتف';
                        }
                        if (emailRegex.hasMatch(value) == false &&
                            value.length != 10) {
                          return 'الرجاء ادخال ايمايل صحيح او رقم هاتف صحيح';
                        }

                        return null;
                      },
                      txt: 'البريد الالكتروني او رقم الهاتف',
                    ),
                    CustomTxtFild(
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty || value.isEmpty) {
                          return 'الرجاء ادخال كلمة سر';
                        }

                        return null;
                      },
                      prefixIcon: const Icon(Icons.visibility),
                      txt: 'كلمه السر',
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Password(_emailController.text)));
                            },
                            child: const Text(
                              'هل نسيت كلمه السر؟',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: kcolor1),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomBtnLog(
                      Txtcolor: Colors.white,
                      title: 'الدخول',
                      backgroundColor: kcolor1,
                      onPressed: () async {
                        print(
                            "çççççççççççççççççççççççççççç${_emailController.text}");
                        print(_passwordController.text);
                        bool result = _formKey.currentState!.validate();
                        if (result) {
                          final emailRegex = RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  title: Center(
                                    child: Text("جار تسجيل الدخول "),
                                  ),
                                  content: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Center(
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                );
                              });

                          await Future.delayed(const Duration(seconds: 3),
                              () async {
                            try {
                              if (emailRegex.hasMatch(_emailController.text)) {
                                UserCredential userCredential =
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                                DocumentSnapshot doc = await FirebaseFirestore
                                    .instance
                                    .collection("handman")
                                    .doc(userCredential.user!.uid)
                                    .get();
                                if (doc.exists) {
                                  Navigator.of(context).pop();

                                  Get.off(HomePageHandMan(uid: doc.id));
                                } else {
                                  Navigator.of(context).pop();

                                  Get.off(
                                      HomePage(uid: userCredential.user!.uid));
                                }
                              } else {
                                QuerySnapshot<Map<String, dynamic>> q =
                                    await FirebaseFirestore.instance
                                        .collection("handman")
                                        .where("password",
                                            isEqualTo: _passwordController.text)
                                        .where("phone",
                                            isEqualTo:
                                                "+20${_emailController.text}")
                                        .get();

                                if (q.docs.isEmpty) {
                                  QuerySnapshot<Map<String, dynamic>> q2 =
                                      await FirebaseFirestore.instance
                                          .collection("users")
                                          .where("password",
                                              isEqualTo:
                                                  _passwordController.text)
                                          .where("phone",
                                              isEqualTo:
                                                  "+20${_emailController.text}")
                                          .get();
                                  print("*****************2");
                                  print(q2.docs.isEmpty);
                                  print("+20${_emailController.text}");
                                  print(_passwordController.text);
                                  if (q2.docs.isEmpty) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text("Error "),
                                            content: SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: Center(
                                                child: Container(
                                                  child: const Text(
                                                      "Error in phone or password"),
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  } else {
                                    print("user-------------------------");
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const AlertDialog(
                                            title: Text("جار الدخول"),
                                            content: SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: Center(
                                                child: SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                    await Future.delayed(
                                        const Duration(seconds: 3), () async {
                                      await FirebaseAuth.instance
                                          .verifyPhoneNumber(
                                        phoneNumber:
                                            "+20${_emailController.text}",
                                        timeout: const Duration(seconds: 60),
                                        verificationCompleted:
                                            (PhoneAuthCredential
                                                phoneAuthCredential) {
                                          // Auto-resolving SMS code (this could happen when the phone number
                                          // is already verified on this device)
                                          print(
                                              "Verification completed automatically");

                                          Get.off(HomePage());

                                          // Optionally, you can sign in the user directly if you want
                                          // await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
                                        },
                                        verificationFailed:
                                            (FirebaseAuthException
                                                authException) {
                                          // Handle error when verification fails
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text("Error"),
                                                  content: Text(
                                                      "${authException.message}"),
                                                );
                                              });

                                          // Optionally, show an error message to the user
                                        },
                                        codeSent: (String verificationId,
                                            int? forceResendingToken) {
                                          Get.to(Verfiy(
                                            name: null,
                                            verification_id: verificationId,
                                            phone: _emailController.text,
                                            work: "user",
                                          ));

                                          // Store the verificationId for later use to verify the code
                                          // You can also use forceResendingToken to resend the code if needed
                                        },
                                        codeAutoRetrievalTimeout:
                                            (String verificationId) {
                                          // Handle when the code auto retrieval times out
                                          print("Code auto-retrieval timeout");
                                          // Optionally, notify the user to enter the code manually
                                        },
                                      );
                                    });
                                  }
                                } else {
                                  print("handman-------------------------");
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const AlertDialog(
                                          title: Text("جار الدخول"),
                                          content: SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: Center(
                                              child: SizedBox(
                                                width: 20,
                                                height: 20,
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                  await Future.delayed(
                                      const Duration(seconds: 3), () async {
                                    await FirebaseAuth.instance
                                        .verifyPhoneNumber(
                                      phoneNumber:
                                          "+20${_emailController.text}",
                                      timeout: const Duration(seconds: 60),
                                      verificationCompleted:
                                          (PhoneAuthCredential
                                              phoneAuthCredential) {
                                        // Auto-resolving SMS code (this could happen when the phone number
                                        // is already verified on this device)
                                        print(
                                            "Verification completed automatically");

                                        Get.off(HomePageHandMan());

                                        // Optionally, you can sign in the user directly if you want
                                        // await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
                                      },
                                      verificationFailed: (FirebaseAuthException
                                          authException) {
                                        // Handle error when verification fails
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text("Error"),
                                                content: Text(
                                                    "${authException.message}"),
                                              );
                                            });

                                        // Optionally, show an error message to the user
                                      },
                                      codeSent: (String verificationId,
                                          int? forceResendingToken) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Verfiy(
                                              name: null,
                                              phone:
                                                  "+20${_emailController.text}",
                                              verification_id: verificationId,
                                              work: "handman",
                                            ),
                                          ),
                                        );

                                        // Store the verificationId for later use to verify the code
                                        // You can also use forceResendingToken to resend the code if needed
                                      },
                                      codeAutoRetrievalTimeout:
                                          (String verificationId) {
                                        // Handle when the code auto retrieval times out
                                        print("Code auto-retrieval timeout");
                                        // Optionally, notify the user to enter the code manually
                                      },
                                    );
                                  });
                                }
                              }
                            } on FirebaseAuthException catch (e) {
                              Navigator.of(context).pop();
                              print("-------------------------");
                              print(e.message);
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Center(
                                        child: Text("Error "),
                                      ),
                                      content: SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Center(
                                          child: Container(
                                            child: Text(e.code ==
                                                    "invalid-credential"
                                                ? "Password or email incorrect"
                                                : ""),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            }
                          });
                        }
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignHandMan(),
                                ),
                              );
                            },
                            child: const Text(
                              'سجل حسابك دلوقتى',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: kcolor1),
                            )),
                        const Text(
                          '   لسه جديد؟',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
