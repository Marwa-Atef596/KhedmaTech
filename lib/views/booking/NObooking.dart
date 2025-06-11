import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../core/constent.dart';
import 'farward2.dart';
import 'refusedbooking.dart';
import '../handman_Booking_completed.dart';
import '../widget/handman_Booking_forward.dart';
import '../widget/handman_booking.dart';
import 'completebooking.dart';

class NoBooking extends StatefulWidget {
  const NoBooking({super.key});

  @override
  State<NoBooking> createState() => _NoBookingState();
}

class _NoBookingState extends State<NoBooking>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;


  int current_index=0;

  @override
  void initState() {
    super.initState();
    set_type();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 2, // Set initial index to the rightmost tab
    );
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          current_index = _tabController.index;
        });
      }
    });
    _initializeAsync();




  }
  Future<void> _initializeAsync() async {
    // Simulate an asynchronous operation
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isInitialized = true;
    });
  }

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
    print("...........................................${FirebaseAuth.instance.currentUser!.uid}");
    print(type);
  }

  List<Widget> widgets = [
    const RefusedBooking(),
    const CompleteBooking(),
    const FarwardBooking2(),
  ];
  List<Widget> widgets2 = [
    const handman_Booking(),
    const handman_Booking_completed(),
    const handman_Booking_forward(),
  ];
  bool _isInitialized = false;


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(children: [
          const SizedBox(
            height: 10,
          ),
          const Align(
            alignment: Alignment.topRight,
            child: Text(
              'الحجوزات',
              style: txtstyle2,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TabBar(

            labelStyle: txtstyletab,
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelColor: background,
            labelColor: kcolor1,
            indicatorColor: kcolor1,
            dividerColor: kcolor1,
            controller: _tabController,
            isScrollable: true,
            indicator: const BoxDecoration(
              border: Border(bottom: BorderSide(color: kcolor1, width: 2)),
            ),
            tabs: const [
              Tab(
                text: 'الملغية',
              ),
              Tab(
                text: 'المكتملة',
              ),
              Tab(
                text: 'القادمة',
              ),
            ],
          ),
          Expanded(
            child: _isInitialized
                ? TabBarView(
              controller: _tabController,
              children: const [
                RefusedBooking(),
                CompleteBooking(),
                FarwardBooking2(),
              ],
            )
                : const Center(child: CircularProgressIndicator()),
          ),
        ]),
      )),
    );
  }
}
