import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khedma_tech/views/profile/profile.dart';
import 'package:khedma_tech/views/widget/custom_bottom_navigate.dart';

import 'booking/NObooking.dart';
import 'chat/chat_list_screen.dart';
import 'contactus/privecy.dart';
import 'home.dart';

class HomePage extends StatefulWidget {
  String? uid;
  HomePage({super.key, this.uid});

  @override
  State<HomePage> createState() => _HomePageState(uid);
}

class _HomePageState extends State<HomePage> {
  String? uid;
  _HomePageState(String? this.uid);
 static int _currentIndex = 4;
  @override
  void initState() {
    super.initState();
    print("//////////////////////////////////");
    print(FirebaseAuth.instance.currentUser!.uid);
  }



  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      Profile("users"),
      NoBooking(),
      ChatListView(),
      Privecy(),
      Home(),
    ];
    return WillPopScope(
      onWillPop: () async => false,
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
                FontAwesomeIcons.bookBookmark,
                size: 28,
              ),
              label: 'الحجوزات',
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
                FontAwesomeIcons.locationDot,
                size: 28,
              ),
              label: 'القريب منك',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.house,
                size: 28,
              ),
              label: 'الرئيسيه',
            ),
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
