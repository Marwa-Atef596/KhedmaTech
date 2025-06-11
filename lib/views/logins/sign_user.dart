import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constent.dart';
import 'log.dart';
import 'national_id_user.dart';
import 'widget/custom_btn_log.dart';
import '../widget/customTxtFild.dart';
import '../widget/custom_contianer.dart';
import '../widget/custom_txt_logs.dart';

class SignUser extends StatelessWidget {
  SignUser({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Future<bool> Verify_existance_email_user(String email) async {
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .get();
    if (qs.docs.isNotEmpty) {
      return true;
    }
    QuerySnapshot qs2 = await FirebaseFirestore.instance
        .collection("handman")
        .where("email", isEqualTo: email)
        .get();
    if (qs2.docs.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<bool> Verify_existance_user(String phone) async {
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection("users")
        .where("phone", isEqualTo: "+20$phone")
        .get();
    if (qs.docs.isNotEmpty) {
      return true;
    }
    QuerySnapshot qs2 = await FirebaseFirestore.instance
        .collection("handman")
        .where("phone", isEqualTo: "+20$phone")
        .get();
    if (qs2.docs.isNotEmpty) {
      return true;
    }
    return false;
  }

  void go_to_id_num_whith_email(String name, String phone, String email,
      String password, BuildContext c) {
    Get.off(national_id_user(true, name, phone, email, password));
  }

  void go_to_id_num_whithout_email(String name, String phone, String email,
      String password, BuildContext c) {
    Get.off(national_id_user(false, name, phone, email, password));
  }

  Future<void> Handle_Signin(String name, String phone, String email,
      String password, BuildContext c) async {
    if (email.isEmpty) {
      if (await Verify_existance_user(phone) == false) {
        go_to_id_num_whithout_email(name, phone, email, password, c);
      } else {
        Get.snackbar("Error", "رقم هاتف مستعمل من قبل",
            backgroundColor: Colors.blue);
      }
    } else {
      if (await Verify_existance_user(phone) == false) {
        if (await Verify_existance_email_user(email) == false) {
          go_to_id_num_whith_email(name, phone, email, password, c);
        } else {
          Get.snackbar("Error", "ايمايل مستعمل من قبل",
              backgroundColor: Colors.blue);
        }
      } else {
        Get.snackbar("Error", "رقم هاتف مستعمل من قبل",
            backgroundColor: Colors.blue);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomContainer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      child: CustomTxtLogs(
                        txt: 'اهلا',
                        title: 'انشاء حساب جديد',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTxtFild(
                      controller: _nameController,
                      validator: (value) {
                        print(value);
                        if (value!.isEmpty || value.isEmpty) {
                          return 'الرجاء ادخال الاسم';
                        }
                        return null;
                      },
                      txt: 'الاسم',
                    ),
                    CustomTxtFild(
                      prefixIcon: Container(
                        margin: const EdgeInsets.only(top: 15, left: 15),
                        child: const Text(
                          "+20",
                          textDirection: TextDirection.ltr,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      validator: (value) {
                        print(value);
                        if (value!.isEmpty ||
                            value.isEmpty ||
                            value.length != 10) {
                          return '   الرجاء ادخال رقم هاتف صحيح ';
                        }
                        return null;
                      },
                      txt: 'رقم الهاتف',
                    ),
                    CustomTxtFild(
                      controller: _emailController,
                      txt: 'البريد الالكتروني',
                      prefixIcon: const SizedBox(
                        child: Center(
                          widthFactor: 0.0,
                          child: Text('(اختياري) '),
                        ),
                      ),
                    ),
                    CustomTxtFild(
                      controller: _passwordController,
                      validator: (value) {
                        print(value);
                        if (value!.isEmpty || value.isEmpty) {
                          return 'الرجاء ادخال كلمة السر';
                        }
                        return null;
                      },
                      prefixIcon: const Icon(Icons.visibility),
                      txt: 'كلمه السر',
                      obscureText: true,
                    ),
                    CustomTxtFild(
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'كلمة المرور غير مطابقة';
                        }
                        return null;
                      },
                      prefixIcon: const Icon(Icons.visibility),
                      txt: 'تأكيد كلمه السر',
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomBtnLog(
                      Txtcolor: Colors.white,
                      title: 'انشاء حساب',
                      backgroundColor: kcolor1,
                      onPressed: () async {
                        bool result = _formKey.currentState!.validate();
                        if (result == true) {
                          Handle_Signin(
                              _nameController.text,
                              _phoneController.text,
                              _emailController.text,
                              _passwordController.text,
                              context);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {
                              Get.to(Log());
                            },
                            child: const Text(
                              'سجل دخول',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: kcolor1),
                            )),
                        const Text(
                          '   عندك حساب؟',
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
            ),
          ],
        ),
      ),
    );
  }
}
