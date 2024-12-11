import 'package:go_router/go_router.dart';
import '../splash_view.dart';
import '../views/home_view.dart';

abstract class AppRouter {
  static const kHomeView = '/homeview';
  static const knewpass = '/knewpass';
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kHomeView,
        builder: (context, state) => const HomeView(),
      ),
      //  GoRoute(
      //   path: knewpass,
      //   builder: (context, state) => const NewPass(),
      // ),
      
     
    ],
  );
}

