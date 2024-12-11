
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/app_router.dart';
import '../core/assets.dart';
import '../views/sliding_text.dart';
class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;
  @override
  void initState() {
    super.initState();
    initslidinganimation();
    navigatetohome();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(AssetsData.logo,height: 150),
        // const SizedBox(
        //   height: 2,
        // ),
        SlidingText(slidingAnimation: slidingAnimation)
      ],
    );
  }

  void initslidinganimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    slidingAnimation =
        Tween<Offset>(begin: const Offset(0, 2), end: Offset.zero)
            .animate(animationController);
    animationController.forward();
  }

  void navigatetohome() {
    Future.delayed(const Duration(seconds: 3), () {
      GoRouter.of(context).push(AppRouter.kHomeView);
      //  Get.to(() => const HomeView(),transition: Transition.fade,duration: Ktrandtionduration);
    });
  }
}
