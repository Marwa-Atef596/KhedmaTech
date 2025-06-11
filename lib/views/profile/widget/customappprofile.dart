import 'package:flutter/material.dart';

import '../../../core/constent.dart';
import '../editprofile.dart';
import 'customCurveClipper.dart';
import 'customaddprofile.dart';

class customappprofile extends StatelessWidget {
  String? type;
   customappprofile(this.type, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurveClipper(),
      child: Container(
        width: double.infinity,
        height: 280,
        color: kcolorc3,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AddProfile(
                txt: 'الملف الشخصي ',
              ),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: background, shape: BoxShape.circle),
                    width: 180,
                    child: Image.asset(
                      'assets/images/11.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    width: 40,
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfile(type),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: kcolor1,
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
