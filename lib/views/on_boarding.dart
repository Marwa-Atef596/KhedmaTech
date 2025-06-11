import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/constent.dart';
import 'logins/login.dart';
import 'widget/custom_button.dart';
import 'widget/custom_button2.dart';
import 'widget/on_boarding_page.dart';

// ignore: use_key_in_widget_constructors
class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  final List<Widget> _pages = [
    const OnboardingPage(
      title: 'تقدر تطلب خدمتك من \nاي مكان انت فيه',
      imageUrl: 'assets/images/1.png',
    ),
    const OnboardingPage(
      title: 'الحرفي هيوصلك في \nاسرع وقت',
      imageUrl: 'assets/images/2.png',
    ),
    const OnboardingPage(
      title: 'لو انت حرفي ممكن \nتسجل معانا',
      imageUrl: 'assets/images/3.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.toInt();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Expanded(
          child: PageView.builder(
            reverse: true,
            controller: _pageController,
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              return _pages[index];
            },
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildPageIndicator(),
        ),
        const SizedBox(
          height: 50,
        ),
        if (_currentPage == 0)
          Column(
            children: [
              CustomButton(

                pageController: _pageController,
                title: 'التالى',
                onPressed: () {
                  
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                },
              ),
              const SizedBox(
                height: 68,
              ),
            ],
          ),
        if (_currentPage == 1)
          Column(
            children: [
              CustomButton(
                pageController: _pageController,
                title: 'التالى',
                onPressed: () {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton2(
                pageController: _pageController,
                title: 'العوده',
              )
            ],
          ),
        if (_currentPage == _pages.length - 1)
          Column(
            children: [
              CustomButton(
                pageController: _pageController,
                title: 'يلا نبدأ',
                onPressed: () {

                  Get.to(const Login());
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton2(
                pageController: _pageController,
                title: 'العوده',
              )
            ],
          ),
        const SizedBox(
          height: 40,
        ),
      ],
    )));
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < _pages.length; i++) {
      indicators.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }

    return indicators.reversed.toList();
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      height: 12.0,
      width: isActive ? 40.0 : 10.0,
      decoration: const BoxDecoration(
        color: kcolor2icon,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
