import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../dashboard/widget/Customcustomsammry.dart';
import '../widget/custom_handman.dart';
import '../../core/constent.dart';
import '../dashboard/widget/allrecommend.dart';
import '../widget/custom_address.dart';
import 'widget/custombottomservice.dart';
import 'widget/customfixedservice.dart';
import 'widget/custominfoservice.dart';
import 'widget/customrowservice.dart';
import 'widget/customsercicenamerate.dart';

class ServiceCarpenter extends StatelessWidget {
  const ServiceCarpenter({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: const CustomBottomService(),
      body: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.circular(8)),
                  child: Image.asset(
                    'assets/images/11.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    children: [
                      customrowservice(txtt: 'نجار'),
                      const customsercicenamerate(),
                      CustomInfoService(
                        iconData: FontAwesomeIcons.locationDot,
                        text: '٤٥ ملك حفني الاسكندريه',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomInfoService(
                        iconData: FontAwesomeIcons.phoneFlip,
                        text: '010123456789',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const customfixedservice(),
                      const SizedBox(
                        height: 16,
                      ),
                      const Divider(
                        color: kbook,
                        thickness: 2,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'التقييم والمراجعات',
                              style: txtstyle11,
                            ),
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomAdderss(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const AllRecommend(),
                                        ),
                                      );
                                    },
                                    txt: '',
                                  ),
                                   customtxtrate(""),
                                ],
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 10,
                              itemBuilder: (BuildContext context, int index) {
                                return const Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: CustomSammry(),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    ));
  }
}
