import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'splash_view.dart';
import 'views/home_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const KhedmaTech());
}

class KhedmaTech extends StatelessWidget {
  const KhedmaTech({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: '/',
          page: () => const SplashView(),
        ),
        GetPage(
          name: '/homeview',
          page: () => const HomeView(),
        )
      ],

      theme: ThemeData(fontFamily: 'Almarai'),

      // theme: ThemeData(
      //   textTheme: GoogleFonts.almaraiTextTheme(
      //     Theme.of(context).textTheme,
      //   ),
      // ),
    );
  }
}
