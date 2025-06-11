import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constent.dart';
import 'id.dart';
import 'log.dart';
import 'widget/custom_btn_log.dart';
import '../widget/customTxtFild.dart';
import '../widget/custom_contianer.dart';
import '../widget/custom_txt_logs.dart';

class SignHandMan extends StatefulWidget {
//  final void Function(String, String, String, String) onSubmit;

  const SignHandMan({
    super.key,
  });

  @override
  State<SignHandMan> createState() => _SignHandManState();
}

class _SignHandManState extends State<SignHandMan> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String _errorMessage = '';
  // bool _isButtonEnabled = true;
  // void _validateForm() {
  //   bool isValid = _formKey.currentState!.validate();
  //   setState(() {
  //     _isButtonEnabled = isValid;
  //   });
  // }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String phone = _phoneController.text;
      String email = _emailController.text.trim();
      String password = _passwordController.text;
      // widget.onSubmit(name, phone, email, password);
      phone = "+20$phone";
      print(phone);
      try {
        if (email.isEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => IdNum(false, name, phone, email, password),
            ),
          );
        } else {
          UserCredential userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => IdNum(true, name, phone, email, password),
            ),
          );
        }

        // User signed up successfully
        // You can navigate to the profile page or perform other actions here
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          setState(() {
            _errorMessage = 'كلمة المرور ضعيفة جدًا.';
          });
        } else if (e.code == 'email-already-in-use') {
          setState(() {
            _errorMessage = 'الحساب موجود بالفعل لهذا البريد الإلكتروني.';
          });
        }
      } catch (e) {
        setState(() {
          _errorMessage = 'Error: $e';
        });
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
                      height: 10,
                    ),
                    CustomTxtFild(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'من فضلك أدخل إسمك';
                        }
                        return null;
                      },
                      controller: _nameController,
                      txt: 'الاسم',
                    ),
                    CustomTxtFild(
                      prefixIcon: Container(
                        margin: const EdgeInsets.only(top: 14, left: 10),
                        child: const Text(
                          "+20",
                          textDirection: TextDirection.ltr,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'من فضلك أدخل رقم الهاتف';
                        }
                        if (value.length != 10) {
                          return 'من فضلك أدخل رقم هاتف مكون من 10 أرقام';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      txt: 'رقم الهاتف',
                    ),
                    CustomTxtFild(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      //  validator: (p0) => null,
                      txt: 'البريد الالكتروني ',
                      prefixIcon: const SizedBox(
                        child: Center(
                          widthFactor: 0.0,
                          child: Text('(اختياري)  '),
                        ),
                      ),
                    ),
                    CustomTxtFild(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'من فضلك أدخل الرقم السرى';
                        }
                        return null;
                      },
                      controller: _passwordController,
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
                      controller: _confirmPasswordController,
                      prefixIcon: const Icon(Icons.visibility),
                      txt: 'تأكيد كلمه السر',
                      obscureText: true,
                    ),
                    if (_errorMessage.isNotEmpty)
                      Text(
                        _errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomBtnLog(
                      Txtcolor: Colors.white,
                      title: 'التالى',
                      backgroundColor: kcolor1,
                      onPressed: () {
                        bool result = _formKey.currentState!.validate();
                        if (result) {
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Log()));
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

void go_to_id_num_whithout_email(
    String name, String phone, String email, String password, BuildContext c) {
  Get.off(IdNum(false, name, phone, email, password));
}

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

void go_to_id_num_whith_email(
    String name, String phone, String email, String password, BuildContext c) {
  Get.off(IdNum(true, name, phone, email, password));
}

void Handle_Signin(String name, String phone, String email, String password,
    BuildContext c) async {
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
