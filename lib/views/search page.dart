import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:khedma_tech/core/constent.dart';
import 'package:khedma_tech/views/result_search.dart';
import 'package:khedma_tech/views/widget/custom%20bottom%20rate.dart';
import 'package:khedma_tech/views/widget/customListBottom.dart';
import 'package:khedma_tech/views/widget/custom_notify.dart';
import 'package:khedma_tech/views/widget/custom_slider.dart';
import 'logins/widget/custom_btn_log.dart';
import 'widget/custom_filter.dart';
import 'widget/custom_handman.dart';
import 'widget/custom_txt_home.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> ratings = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
  ];
  int? _selectedIndex;
  RangeValues _currentRangeValues = const RangeValues(0, 150);
  TextEditingController _contr = TextEditingController();
  String _searchQuery = "";
  List<String> ServiceName = [
     'الكل',
    'كهرباء',
    'سباكه',
    'نجاره',
    'نظافة',
    'تكييفات',
    'دهانات',
    'ستايلات'
  ];
  @override
  void initState() {
    super.initState();
    _contr.addListener(() {
      setState(() {
        _searchQuery = _contr.text;

      });
    });
    myController.updateVariable1(0);
    myController.updateVariable1(0);
    myController.updateVariable3(0);
    myController.updateVariable4(0);
  }

  @override
  void dispose() {
    _contr.dispose();
    super.dispose();
  }
  final MyController myController = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    int index1_default=99;
    int index2_default=99;
    int index3_default=99;
    int index4_default=99;

    Map filter = {};
    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Search Tasks'),
        ),
        body: Center(
          child: Text('No user is currently signed in.'),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomNotify(
                  icon: Icons.arrow_forward,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          myController.updateVariable1(0);
                          myController.updateVariable2(0);
                          myController.updateVariable3(0);
                          //myController.updateVariable4(0);

                          showModalBottomSheet(
                            showDragHandle: true,
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                            ),
                            builder: (BuildContext context) {
                              return SizedBox(
                                  height: 800,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          const Align(
                                            child: Text(
                                              'الفلتر',
                                              style: txtstyle2,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 16),
                                            child: Divider(
                                              color: Color(0xffC7EEFF),
                                              thickness: 2,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            'الخدمات ',
                                            style: txtstyle444,
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          customlistviewbottom(ServiceNames:this.ServiceName),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          const Text(
                                            'سعر المعاينة ',
                                            style: txtstyle444,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          RangeSliderExample(this._currentRangeValues! ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            'التقييم',
                                            style: txtstyle444,
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          custombottomrate(RatingNames:this.ratings ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 16),
                                            child: Divider(
                                              color: Color(0xffC7EEFF),
                                              thickness: 2,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                         /* CustomBtnLog(
                                            title: 'فلتر',
                                            onPressed: () {
                                              final MyController myController = Get.find();
                                              print("filter filter ");
                                              int index1=myController.variable1.value;
                                              int  index2=myController.variable2.value;
                                              int index3=myController.variable3.value;
                                              int index4=myController.variable4.value;
                                              print(index1);
                                              print(index2);
                                              print(index3);
                                              print(index4);

                                              Navigator.of(context).pop();

                                            },
                                            backgroundColor: kcolor1,
                                          )*/
                                        ],
                                      ),
                                    ),
                                  ));
                            },
                          );
                        },
                        child: Container(
                            width: 57,
                            height: 57,
                            margin: const EdgeInsets.only(left: 2),
                            decoration: BoxDecoration(
                                color: const Color(0xffFFFFFF),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 0.5,
                                  )
                                ]),
                            child: Image.asset(
                              'assets/images/l-removebg-preview.png',
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 250,
                      child: TextField(
                        controller: _contr,

                        onChanged: (value) {},
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
                                borderSide:
                                    BorderSide(color: kcolor1, width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: kcolor1, width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            suffixIcon:
                                const Icon(FontAwesomeIcons.magnifyingGlass),
                            suffixIconColor: kcolor2icon,
                            hintText: "بتدور ايه",
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)))),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "$_searchQuery",
                      style: txtstyle,
                    ),
                    Text(
                      ' نتائج ل',
                      style: txtstyle1,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Obx(() {
                  int index1 = myController.variable1.value;
                  int index2 = myController.variable2.value;
                  int index3 = myController.variable3.value;
                  int index4 = myController.variable4.value;
                  print("<<<<<<<<<<<<<----->>>>>>>>>>>>>>>");
                  print(index1);
                  print(index2);
                  print(index3);
                  print(index4);
                  return StreamBuilder<List<DocumentSnapshot>>(
                    stream: getFilteredHandymen(_searchQuery, index1, index2, index3,double.parse(ratings[index4])),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Something went wrong'),
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                          child: Text('No handyman found'),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map<String, dynamic> data =
                          snapshot.data![index].data() as Map<String, dynamic>;
                          print("daata dataa ");
                          print(data);
                          return Padding(
                            padding: EdgeInsets.only(bottom: 16),
                            child: HandMan(snapshot.data![index].id),
                          );
                        },
                      );
                    },
                  );
                })
                    ,
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        ),
      ),
    );
  }
  Stream<List<DocumentSnapshot>> getFilteredHandymen(String searchQuery, int? index1, int? index2, int? index3, double minAverageRank) async* {
    CollectionReference handmanCollection = FirebaseFirestore.instance.collection('handman');
    Query query = handmanCollection;

    // Check if searchQuery is not empty
    if (searchQuery.isNotEmpty) {
      query = query.where('name', isEqualTo: searchQuery);
    }

    // Adjust default values if index1, index2, or index3 are 99

    int? adjustedIndex1 = index1 == 0 ? null : index1;
    int? adjustedIndex2 = index2 == 0 ? null : index2;
    int? adjustedIndex3 = index3 == 0 ? null : index3;
    double? adjustedIndex4 = minAverageRank ;



    // Apply filters only if adjustedIndex1 is not null



      if(adjustedIndex1 != null)   query = query.where('work', isEqualTo: ServiceName[adjustedIndex1]);

      // Fetch the documents from Firestore
      Stream<QuerySnapshot> querySnapshots = query.snapshots();

      await for (QuerySnapshot snapshot in querySnapshots) {

        List<DocumentSnapshot> filteredDocuments = snapshot.docs.where((doc) {

          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          // Convert price to a number
          double? price = double.tryParse(data['price'].toString());
          if (price == null) return false;



          // Calculate average rank
          List<dynamic> ranks = data['ranks'];
          double averageRank=0;
          if (ranks.isEmpty)
            {
               averageRank=0;
            }
          else
            {
              double sumOfRanks = 0;
              int rankCount = 0;

              for (var rank in ranks) {
                if (rank.containsKey('value')) {
                  dynamic value = rank['value'];
                  if (value is int) {
                    sumOfRanks += value.toDouble(); // Convert int to double for summing
                    rankCount++;
                  } else if (value is double) {
                    sumOfRanks += value;
                    rankCount++;
                  }
                }
              }

               averageRank = rankCount > 0 ? sumOfRanks / rankCount : 0;
              // Handle empty ranks case
          }


          print("THE DOC");

          print(price);
          print(averageRank);
          print("RANK");
          print("price");
          print(price>=0 && price<=150);

          // Apply filters
          return (adjustedIndex2!=null? price >= adjustedIndex2:price>=0) &&
              (adjustedIndex3!=null ? price <= adjustedIndex3:price<=150) &&
              averageRank >= minAverageRank;
        }).toList();

        yield filteredDocuments;
      }

  }
}

class MyController extends GetxController {
  @override
  void onInit() {
    // Called immediately after the controller is initialized
    super.onInit();
    // You can define a function to reset variables
  }


  var variable1 = 0.obs;
  var variable2 = 0.obs;

  var variable3 = 0.obs;
  var variable4=0.obs;

  // Methods to update variables
  void updateVariable1(int value) {
    variable1.value = value;
  }

  void updateVariable2(int value) {
    variable2.value = value;
  }

  void updateVariable3(int value) {
    variable3.value = value;
  }
  void updateVariable4(int value) {
    variable4.value = value;
  }
}
