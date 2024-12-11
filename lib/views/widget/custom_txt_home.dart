import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khedma_tech/views/search%20page.dart';

import '../../core/constent.dart';

// ignore: must_be_immutable
class CustomTxtHome extends StatelessWidget {
   CustomTxtHome({
    super.key,
    this.hintText,this.c
  });
  String? hintText;
  TextEditingController? c;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 295,
      child: Form(
        child: TextFormField(

          onChanged: (value){
            print("--------------------------------");
            print(value);
            print(c!.text);
          },

          
          onTap: () {

          if(c!.text!="")  Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  SearchPage(),
              ),
            );
          },
          textAlign: TextAlign.right,
          //  onSaved: (newValue) {
          //   email = newValue!;
          // },
          // validator: (value) {
          //   if (value!.length > 50) {
          //     return "Email can't be more than 100";
          //   }
          //   if (value.length < 5) {
          //     return "Email can't be less than 5";
          //   }
          //   return null;
          // },
          // keyboardType:
          //     TextInputType.emailAddress,
          decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: kcolor1, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: kcolor1, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              suffixIcon: const Icon(FontAwesomeIcons.magnifyingGlass),
              suffixIconColor: kcolor2icon,
              hintText: hintText,
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)))),
        ),
      ),
    );
  }
}
