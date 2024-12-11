// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:khedma_tech/views/logins/log.dart';
import 'package:khedma_tech/views/logins/login.dart';
import '../../../core/constent.dart';
import 'custom_btn_log.dart';

class ShowDialogg extends StatelessWidget {
  ShowDialogg({
    super.key,
    this.image,
    this.txt,
    this.txt2,
  });
  String? txt;
  String? txt2;
  String? image;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 30,
              ),
              Image.asset(image!),
              const SizedBox(
                height: 20,
              ),
              const Text(
                '! تهانينا',
                style: txtstyle4,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                txt!,
                style: txtstyle5,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomBtnLog(
                title: txt2,
                backgroundColor: kcolor1,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  Login(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
