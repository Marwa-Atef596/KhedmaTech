import 'package:flutter/material.dart';

import '../../../core/assets.dart';
import '../../../core/constent.dart';

// ignore: must_be_immutable
class DialogRate extends StatelessWidget {
  DialogRate({super.key, this.txt});
  String? txt;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(onPressed: () {
                Navigator.of(context).pop();
              }, icon: const Icon(Icons.close)),
              Image.asset(AssetsData.imgawe3),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  txt!,
                  style: txtstyle444,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
