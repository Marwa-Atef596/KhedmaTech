import 'package:flutter/material.dart';
import '../../core/constent.dart';

// ignore: must_be_immutable
class CustomTxtFild extends StatelessWidget {
  CustomTxtFild({
    super.key,
    this.controller,
    this.onchanged,
    this.txt,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
  });
  String? txt;
  Widget? prefixIcon;
  bool obscureText;
  String? Function(String?)? validator;
  TextEditingController? controller;
  Function(String)? onchanged;
  TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(txt!),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Directionality(
          textDirection: TextDirection.rtl,
          child: TextFormField(

            textDirection: TextDirection.ltr,
            controller: controller,
            onChanged: onchanged,
            obscureText: obscureText,
            cursorColor: kcolor1,
            textAlign: TextAlign.right,
            validator: validator,
            keyboardType: keyboardType,
            decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: kcolor1, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: kcolor1, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                suffixIcon: prefixIcon,
                suffixIconColor: kcolor2icon,
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)))),
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
