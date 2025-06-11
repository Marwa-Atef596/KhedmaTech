import 'package:flutter/material.dart';
import '../../core/assets.dart';
import '../../core/constent.dart';

import '../widget/customAppService.dart';

class NoNotify extends StatelessWidget {
  const NoNotify({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: customAppService(
                  txxt: 'الاشعارات',
                ),
              ),
              const SizedBox(
                height: 230,
              ),
              const Text(
                'لا يوجد لديك اشعارات',
                style: txtstyle4,
              ),
              Image.asset(
                AssetsData.emp,
                width: 250,
              )
            ],
          ),
        ),
      ),
    );
  }
}
