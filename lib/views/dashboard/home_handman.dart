import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khedma_tech/views/contactus/privecy.dart';
import 'package:khedma_tech/views/widget/custom_bottom_navigate.dart';
import 'package:khedma_tech/views/dashboard/widget/custom_homeHandMan.dart';

import '../booking/NObooking.dart';
import '../chat/chat_list_screen.dart';
import '../home.dart';
import '../profile/profile.dart';

class HomePageHandMan extends StatefulWidget {
  String? uid;
   HomePageHandMan({super.key,this.uid});

  @override
  State<HomePageHandMan> createState() => _HomePageHandManState(uid);
}

class _HomePageHandManState extends State<HomePageHandMan> {
  int _currentIndex = 2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("//////////////////////////////////");
    print(FirebaseAuth.instance.currentUser!.uid);
  }

  final List<Widget> _screens = [
    Profile("handman"),



     ChatListView(),


     HomeHandMan(),

    Home()









  ];
String? uid;
  _HomePageHandManState(String? this.uid);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async=>false,
      child: Scaffold(
        bottomNavigationBar: CustomBottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.user,
                size: 28,
              ),
              label: 'ملفك',
            ),

            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.commentDots,
                size: 28,
              ),
              label: 'الدردشه',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.control_point_duplicate,
                size: 28,
              ),
              label: 'لوحة التحكم',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 28,
              ),
              label: 'الرئيسية',
            )


          ],
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        body: _screens[_currentIndex],
      ),
    );
  }
}
