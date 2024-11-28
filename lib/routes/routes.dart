import 'package:flutter/cupertino.dart';
import 'package:media_booster_app/screen/home/view/home_screen.dart';
import 'package:media_booster_app/screen/music/view/music_screen.dart';
import 'package:media_booster_app/screen/splash/splash_screen.dart';

class AppRoutes {
  static String splashPage = '/';
  static String homePage = 'home';
  static String musicPage = 'music';

  static Map<String, Widget Function(BuildContext)> routes = {
    AppRoutes.splashPage: (_) => const SplashPage(),
    AppRoutes.homePage: (_) => const HomeScreen(),
    AppRoutes.musicPage: (_) => const MusicScreen(),
  };
}
