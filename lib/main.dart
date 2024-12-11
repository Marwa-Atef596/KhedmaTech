import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma_tech/splash_view.dart';
import 'package:khedma_tech/views/home_view.dart';
import 'core/app_router.dart';
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
          page: () => SplashView(),
        ),
        GetPage(
          name: '/homeview',
          page: () => HomeView(),
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
