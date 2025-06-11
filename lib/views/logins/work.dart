import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widget/Check_adress.dart';
import 'widget/custom_btn_log.dart';
import 'widget/custom_worl.dart';
import 'widget/customgrid.dart';
import '../../core/assets.dart';
import '../../core/constent.dart';
import 'checkPhone.dart';

class works extends StatefulWidget {
  bool? email;
  String? name;
  String? phone;
  
  String? useremail;
  String? password;
  String? national_id;
  works(bool email, String name, String phone, String useremail,
      String password, String national_id,
      {super.key}) {
    this.email = email;
    this.name = name;
    this.phone = "+20$phone";
    this.useremail = useremail;
    this.password = password;
    this.national_id = national_id;
  }

  @override
  State<works> createState() => _worksState(
        email!,
        name!,
        phone!,
        useremail!,
        password!,
        national_id!,
      );
}

class _worksState extends State<works> {
  int _selectedDayIndex = 0;
  void _selectDay(int index) {
    setState(() {
      _selectedDayIndex = index;
    });
  }

  List ServiceName = [
    'كهرباء',
    'سباكه',
    'نجاره',
    'نظافة',
    'تكييفات',
    'دهانات',
    'ستايلات'
  ];
  List<Color> colors = [
    kbc1,
    kbc4,
    kbc2,
    kbc5,
    kbc6,
    kbc3,
    kbc7,
  ];
  List<Color> colors2 = [
    kbc11,
    kbc44,
    kbc22,
    kbc55,
    kbc66,
    kbc33,
    kbc77,
  ];
  List<String> imgs = [
    AssetsData.img1,
    AssetsData.img3,
    AssetsData.img2,
    AssetsData.img5,
    AssetsData.img6,
    AssetsData.img4,
    AssetsData.img7,
  ];

  bool? email;
  String? name;
  String? phone;
  String? useremail;
  String? password;
  String? national_id;
  _worksState(
    bool email,
    String name,
    String phone,
    String useremail,
    String password,
    String national_id,
  ) {
    this.email = email;
    this.name = name;
    this.phone = phone;
    this.useremail = useremail;
    this.password = password;
    this.national_id = national_id;
  }
  customgrid cg = customgrid();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Align(
                  alignment: Alignment.topRight,
                  child: Image(
                    image: AssetImage(AssetsData.icon),
                    height: 60,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'اختار حرفتك',
                style: txtstyle2,
              ),
              const SizedBox(
                height: 30,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      crossAxisCount: 2,
                      childAspectRatio: 1.5),
                  itemCount: ServiceName.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == ServiceName.length - 1) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 40,
                            right: 40,
                            bottom: 16,
                          ),
                          child: CustomWork(
                            color: _selectedDayIndex == index
                                ? colors2[index]
                                : colors[index],
                            //   isSelected: _selectedDayIndex == index,
                            onTap: () {
                              print("************************");

                              _selectDay(index);
                              print(ServiceName[_selectedDayIndex]);
                            },
                            borderRadius: BorderRadius.circular(8),

                            image: imgs[index],
                            txt: ServiceName[index],
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 40, right: 40, bottom: 16),
                        child: CustomWork(
                          //   isSelected: _selectedDayIndex == index,
                          onTap: () {
                            print("************************");

                            _selectDay(index);
                            print(ServiceName[_selectedDayIndex]);
                          },
                          borderRadius: BorderRadius.circular(8),
                          color: _selectedDayIndex == index
                              ? colors2[index]
                              : colors[index],
                          image: imgs[index],
                          txt: ServiceName[index],
                        ),
                      );
                    }
                    //bool isselect;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomBtnLog(
                title: 'انشاء حساب',
                backgroundColor: kcolor1,
                onPressed: () async {
                  if (email == false) {
                    Get.off(CheckPhoneNum(name!, phone!, useremail!, password!,
                        national_id!, ServiceName[_selectedDayIndex]));
                  } else {
                    Get.off(check_adress(name!, phone!, useremail!, password!,
                        national_id!, ServiceName[_selectedDayIndex]));
                  }
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
