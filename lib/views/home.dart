import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:khedma_tech/core/constent.dart';
import 'package:khedma_tech/views/RecommendedFavourites/Recommended.dart';
import 'package:khedma_tech/views/notification/notify.dart';
import 'package:khedma_tech/views/search%20page.dart';
import 'package:khedma_tech/views/services%20page.dart';
import 'package:khedma_tech/views/services/electricity.dart';
import 'package:khedma_tech/views/widget/custom_address.dart';
import 'package:khedma_tech/views/widget/custom_handman.dart';
import 'package:khedma_tech/views/widget/custom_notify.dart';
import 'package:khedma_tech/views/widget/custom_service.dart';

import '../core/assets.dart';
import 'services/Air conditioners.dart';
import 'services/Paints.dart';
import 'services/Plumbing.dart';
import 'services/nagar.dart';
import 'widget/custom_filter.dart';
import 'widget/custom_txt_home.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  Home({super.key});
  List ServiceName = [
    'كهرباء',
    'سباكه',
    'نجاره',
    'المزيد',
    'تكييفات',
    'دهانات'
  ];
  List<Color> colors = [kbc1, kbc4, kbc2, kbc7, kbc6, kbc3];
  List<String> imgs = [
    AssetsData.img1,
    AssetsData.img3,
    AssetsData.img2,
    AssetsData.img9,
    AssetsData.img6,
    AssetsData.img4,
  ];

  final Map<int, Widget> itemRoutes = {
    0: const electricity(),
    1: const Plumbing(),
    2: const Carpentry(),
    3: ServicesPage(),
    4: const Airconditioners(),
    5: const Paints(),
  };
  String type = "";
  Future<void> set_type() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("handman")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (doc.exists) {
      type = "handman";
    } else {
      type = "user";
    }
  }

  @override
  Widget build(BuildContext context) {
    set_type();
    return SafeArea(
      child: Scaffold(
        // bottomNavigationBar: CustomBottomNavigationBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: CustomNotify(
                      icon: FontAwesomeIcons.bell,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Notifications(),
                          ),
                        );
                      },
                    )),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'خدمة تك',
                      style: txtstyle22,
                    ),
                    Text(
                      ' اهلا بيك في',
                      style: txtstyle2,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'هنا هتلاقي كل اللي بيتك محتاجه',
                  style: txtstyle44,
                ),
                const SizedBox(
                  height: 16,
                ),

                Container(
                  height: 100,
                  child: TextFormField(
                    onTap: () {
                      final MyController myController = Get.put(MyController());

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchPage(),
                        ),
                      );
                    },
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: kcolor1, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: kcolor1, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        suffixIcon:
                            const Icon(FontAwesomeIcons.magnifyingGlass),
                        suffixIconColor: kcolor2icon,
                        hintText: "بتدور ايه",
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8)))),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  color: Color(0xffBFCFE7),
                  thickness: 2,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomAdderss(
                  txt: 'الخدمات',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ServicesPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomService(
                    onTap: (index) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => itemRoutes[index]!),
                      );
                    },
                    ServiceName: ServiceName,
                    colors: colors,
                    imgs: imgs),
                const Divider(
                  color: Color(0xffBFCFE7),
                  thickness: 2,
                ),
                CustomAdderss(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Recommended(),
                      ),
                    );
                  },
                  txt: 'الحرفيين المرشحيين',
                ),
                const SizedBox(
                  height: 10,
                ),

                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("handman")


                    .snapshots()

                        ,
                    builder: (context, snapshot) {
                      if(snapshot.connectionState==ConnectionState.waiting)
                        {
                          return CircularProgressIndicator();

                        }
                      if(snapshot.hasError)
                        {
                          return Text("Erorr");

                        }
                      if(!snapshot.hasData || snapshot.data!.size==0)
                        {
                          return Text("NO INFO");
                        }
                      if(snapshot.data!.size==1 && snapshot.data!.docs.first.id==FirebaseAuth.instance.currentUser!.uid)
                        {
                          return Text("لا يوجد مرشحين");
                        }
                      List users=[];
                      users=snapshot.data!.docs;
                      users.sort((a, b) {
                        num ranks_a=0;
                        for(int i=0;i<a["ranks"].length;i++)
                          {
                            ranks_a+=a["ranks"][i]["value"];

                          }
                        if(a["ranks"].length!=0)
                        ranks_a=ranks_a/a["ranks"].length;
                        num ranks_b=0;
                        for(int i=0;i<b["ranks"].length;i++)
                        {
                          ranks_b+=b["ranks"][i]["value"];

                        }
                        if(b["ranks"].length!=0)
                        ranks_b=ranks_b/b["ranks"].length;
                        print(ranks_a);
                        print(ranks_b);
                        print(ranks_b.compareTo(ranks_a));
                        print("--------------------");

                       return ranks_b.compareTo(ranks_a);


                      });
                      
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: users.length,
                        itemBuilder: (BuildContext context, int index) {
                          return  Padding(
                            padding: EdgeInsets.only(bottom: 16),
                            child: users[index].id!=FirebaseAuth.instance.currentUser!.uid? HandMan(users[index].id):null,
                          );
                        },
                      );
                    },)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
