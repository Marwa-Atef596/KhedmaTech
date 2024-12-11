import 'package:flutter/material.dart';
import 'package:khedma_tech/core/constent.dart';
import 'package:khedma_tech/views/services/Satellite.dart';
import 'package:khedma_tech/views/widget/custom_service.dart';

import '../core/assets.dart';
import 'services/Air conditioners.dart';
import 'services/Paints.dart';
import 'services/Plumbing.dart';
import 'services/cleanliness.dart';
import 'services/electricity.dart';
import 'services/nagar.dart';
import 'widget/customAppService.dart';

// ignore: must_be_immutable
class ServicesPage extends StatelessWidget {
  ServicesPage({super.key});
  // ignore: non_constant_identifier_names
  List ServiceName = [
    'كهرباء',
    'سباكه',
    'نجاره',
    'نظافة',
    'تكييفات',
    'دهانات',
    'ستايلات و ريسيفر '
  ];
  List<Color> colors = [kbc1, kbc4, kbc2, kbc5, kbc6, kbc3, kbc7];
  List<String> imgs = [
    AssetsData.img1,
    AssetsData.img3,
    AssetsData.img2,
    AssetsData.img5,
    AssetsData.img6,
    AssetsData.img4,
    AssetsData.img7,
  ];
  final Map<int, Widget> itemRoutess = {
    0: const electricity(),
    1: const Plumbing(),
    2: const Carpentry(),
    3: const cleanliness(),
    4: const Airconditioners(),
    5: const Paints(),
    6: const Satellite(),
  };
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
                txxt: 'الخدمات',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: CustomService(
                  onTap: (index) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => itemRoutess[index]!),
                    );


                  },
                  ServiceName: ServiceName,
                  colors: colors,
                  imgs: imgs),
            ),
          ],
        ),
      ),
    ));
  }
}
